# Project-structure quality gates

Defined on 2026-11-11 against [design.md](design.md). These are acceptance criteria for future implementation, not evidence that the starter satisfies them. This document does not authorize source changes or install checking tools.

## Execution and result policy

Apply the relevant gates to each implementation change and review the complete application before release. Check new and changed responsibilities plus their callers; do not require empty folders or abstractions to satisfy a diagram. All applicable gates must pass. A pending integration decision is not a pass for code that depends on it.

Use `pass`, `fail`, `not verified`, or `not applicable` per gate. A failure blocks acceptance of the affected change until corrected or the agreed design is explicitly revised. Not-applicable results require a reason. Documented policy exceptions already allowed by the design, such as a justified cancellation policy, are evaluated against their stated conditions rather than treated as automatic failures.

Structure and architecture gates are review-only. Do not add automated structure/architecture linters, validators, import-boundary checkers, or architecture tests for this project. Review ownership, dependencies, and reuse directly; a clean analyzer or empty search result cannot establish them. Standard Flutter formatting, analysis, build checks, and focused behavioral tests remain separate and are not excluded by this decision. No additional setup stage is required.

## Dependency review

The following boundaries are evaluated through code review. Imports, exports, conditional imports, and barrel re-exports must not bypass them. Resolve both relative and package imports. Examine dependency cycles across responsibility areas; do not reject ordinary references within one cohesive module merely because its files reference each other.

| Area | Allowed project dependencies | Forbidden coupling |
|---|---|---|
| `api` | Its resource modules and shared API configuration | `ui`, `app`; state coupling is subject to G5 below |
| `ui` | Other presentation foundations/widgets within `ui` | `api`, `state`, `app`, remote DTOs, application providers |
| `state` | Shared state modules and API contracts/operations | `ui`, pages, layouts, shared app widgets |
| `app/pages` | `ui`, shared state, API query contracts, applicable layouts/shared widgets, owned page files | Other pages' private implementation details |
| `app/layouts` | `ui`, shared state, shared app widgets, explicit page entry points needed for composition | Page-private state/widgets, endpoint execution or JSON parsing |
| `app/widgets` | `ui`, relevant shared state and API contracts where justified | Page-private implementations or ownership of the app's top-level layout |

Entry points and minimal application setup may compose these areas. Public page entry points and route arguments may be referenced for Navigator composition; this does not permit unrelated pages to depend on each other's internals. No extra public-interface file or export barrel is required. A model's use in multiple places does not automatically require moving it into a global models folder.

External package imports also need responsibility checks: Dio endpoint execution belongs in `api`; Riverpod application-state access does not belong in `ui`. Cached Query UI observation in app widgets/pages is permitted. Flutter rendering and image-loading facilities in presentation code are permitted; these are not domain endpoint calls.

## Gates

### G1 — Models and operations have an explicit owner

**Pass:** Remote DTOs and serialization live under the appropriate API resource. Application-specific models live with their state, page, or widget owner. Endpoint execution and response parsing are outside widgets. Typed source contracts tolerate optional data as required by the product specs.

**Fail examples:** A page parses API JSON; a universal models directory mixes API DTOs and local view state; UI components accept domain DTOs; identical local models are copied without an ownership reason.

**Verification:** Review of imports/dependencies, model declarations, transformations, and endpoint call sites. No extra mapping layer or duplicate DTO-to-domain class is required when it adds no meaning.

### G2 — Shared UI remains atomic and application-independent

**Pass:** `ui` contains application presentation foundations and reusable atomic widgets. Widgets depend on parent-supplied content and their own UI state only. Narrow actions/links/content slots and presentation-only configuration are allowed without changing the widget's intent.

**Fail examples:** Reading an application provider; breed-specific flags; accessing another widget's state; owning root navigation; adding arbitrary header/body/footer regions that turn an atomic control into an application layout.

**Verification:** Review of dependencies, public inputs, and behavior. `StatefulWidget` is not a failure; statelessness here means independence from application and other-widget state. No numerical slot-count limit applies.

### G3 — Pages, layouts, and shared app widgets have distinct purposes

**Pass:** Page-specific widgets and models stay with their high-level view. Layouts own top-level wrappers and shared page coordination. Every item in `app/widgets` has actual cross-page usage and a reason it cannot fit a page or atomic `ui` widget. Detail contexts reuse the full information UI while allowing different page classes/data sources.

**Fail examples:** Moving a widget into a shared folder for hypothetical reuse; copying the full detail UI for each entry context; placing app-navigation/footer composition in an atomic `ui` widget; a miscellaneous components directory with no ownership rationale.

**Verification:** Review callers and ownership. A short explanation in the change review is sufficient; do not create a per-widget registry or force domain options into generic UI to satisfy this gate.

### G4 — Application state and remote query state are not competing authorities

**Pass:** Riverpod owns shared application state; Cached Query owns remote query lifecycle/cache. Local interaction state stays local. The queue is the authority for the current discovery image. A captured details image is a contextual snapshot, not a second mutable current-card authority. Global session lifetime is acceptable.

**Fail examples:** A separate mutable current-image provider drifts from the queue; copying every cached query's loading/error/data into Riverpod; retaining an unnecessary discovery history; adding per-page lifetime machinery without a concrete need.

**Verification:** State ownership/read-write review. Runtime checks of queue advancement and contextual details belong to the linked product scenarios; static checks alone cannot establish consistency.

### G5 — Query policies and callbacks are centralized

**Pass:** Reusable query definitions belong in `api`. Keys, retry/refetch policy, and needed lifecycle/cancellation configuration are declared with those definitions or a shared integration, rather than reinvented by each widget. Success/error callbacks can connect to externally owned state without being redeclared per retrieval site. Widgets may observe a query or invoke an operation and display its state.

**Fail examples:** Widget-owned Dio calls; repeated success/error state-update blocks at each consumer; custom caching or request-sharing machinery duplicating the selected engine; API modules importing widgets; circular API/state dependencies.

**Verification:** Dependency and retrieval-site review, and focused checks of the implemented discovery flow. No standalone query proof is required. The exact callback-to-Riverpod wiring is still open. Before accepting that integration, record its owner, dependency directions, subscription lifetime, cancellation/reuse behavior, and why it requires no DI layer. Do not silently classify an `api` → `state` dependency as approved or prohibited: its resolution must preserve the agreed responsibilities, avoid cycles, and update the dependency table. Until then, the integration portion of this gate is **not verified**; unrelated structural work can still be evaluated.

Repeated configuration is acceptable when centralized and mechanical. Cancellation on loss of consumers is preferred; a package-driven alternative can pass if justified and verified for stale writes, redundant requests, shared consumers, and reuse. No claim of automatic Dio cancellation follows from choosing Cached Query.

### G6 — Discovery coordination belongs to one application owner

**Pass:** Queue advancement/refill orchestration lives with its application state owner, outside presentation widgets. Refill appends each completed execution once, simultaneous triggers share or guard the same work, and failures leave refill retryable. API modules retrieve images and send votes; they do not choose navigation or render recovery. Voting captures the decided image and advances independently of its response.

**Fail examples:** Every page implements refill listeners and appends independently; observing cached results appends the batch again; an image-ID duplicate filter is added to solve execution replay; a content retry resubmits a vote; vote success controls navigation.

**Verification:** Ownership and caller review, followed by focused executable evidence for overlapping refill, remount/cache replay, repeat images, cancellation/failure recovery, and slow/failed voting. These are behavioral prerequisites to accepting the integration, not a requirement to write implementation-mirroring tests.

### G7 — Dependencies and scaffolding remain proportional

**Pass:** The agreed stack is used: Cached Query, Riverpod for state, Dio, Navigator, manually authored remote models, no DI layer/framework. Dependency versions default to stable compatible releases at installation time; a deviation has a concrete reason. Only needed modules and dependencies are introduced.

**Fail examples:** Adding a routing package, a second query engine, DI/service-locator infrastructure, speculative empty feature folders, or mandatory repositories/use-cases/interfaces without an actual problem they solve.

**Verification:** Manifest/lockfile and file-tree diff review. Do not continuously require upgrades merely because a newer stable version appeared after the project's versions were resolved. Ordinary constructors and callbacks do not themselves constitute a DI framework or layer.

### G8 — Structural changes preserve product contracts

**Pass:** Responsibility moves preserve same-image discovery details, full shared breed information, contextual navigation, nonblocking votes, queue continuity/recovery, and the deliberate absence of counters/history. No architectural convenience introduces an excluded feature or silently changes an accepted flow.

**Verification:** Map affected behaviors to the existing capability scenarios and record relevant runtime evidence once implemented. Documentation-only moves require consistency review rather than an app build. Full product acceptance, accessibility, and release checks remain separate delivery gates.

## Evidence and handoff

Each structural implementation review records:

- Exact commit SHA, or base SHA plus the reviewed working-tree diff if uncommitted.
- Applicable gate IDs, result, and concise file/symbol references supporting the result.
- Commands actually executed and their results for standard Flutter checks or focused behavioral tests, where relevant; no automated architecture checker is required or permitted.
- Semantic review findings and resolutions; unresolved integration choices explicitly marked not verified.
- Focused behavioral evidence where G4–G6 or G8 depends on runtime behavior.

Keep this evidence in the change review or an implementation gate log linked from the eventual delivery README. Do not add a second tracking system solely for these gates. Flutter formatting and analysis support code quality but do not replace ownership review. Structure and dependency enforcement remains a review responsibility; no automated boundary enforcement work is planned.
