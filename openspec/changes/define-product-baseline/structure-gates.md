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
| `api` | Its resource modules and shared API configuration | `ui`, `app`, `state` |
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

**Verification:** Dependency and retrieval-site review, and focused checks of the implemented discovery flow. No standalone query proof is required. The discovery integration resolves the boundary as `state` → `api`: the application state owner supplies callbacks once to API query definitions, and API modules do not import state. Session-owned query/cache/transport objects require no DI layer. See [discovery implementation evidence](discovery-implementation.md) for lifetime, cancellation, and checks. Future consumers must preserve that boundary.

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

**Pass:** Responsibility moves preserve same-image discovery details, full shared breed information, contextual navigation, nonblocking votes, queue continuity/recovery, and the deliberate absence of counters and discovery/vote history. Tab-navigation history is explicitly supported. No architectural convenience introduces an excluded feature or silently changes an accepted flow.

**Verification:** Map affected behaviors to the existing capability scenarios and record relevant runtime evidence once implemented. Documentation-only moves require consistency review rather than an app build. Full product acceptance, accessibility, and release checks remain separate delivery gates.

## Maintenance workflow: before and after code changes

Use this workflow with G1–G8, within the feature/change being implemented. It is not a separate project stage, an automated architecture validator, or a requirement to rerun every check for every edit. Apply checks to affected behavior and its consumers; record skipped platform checks as not verified.

### Lessons from implementation

| Observed problem or repeated rework | Preventive check |
|---|---|
| Initial UI resembled Figma without reproducing the complete component families, focus states, effects and styling variables. Icon stroke assumptions also required correction in the design itself. | Inspect current component masters, variants and variables before implementing; distinguish reference inconsistencies from code defects. Do not infer all variants from an application screenshot or silently change the design. |
| Button/tab fixes affected hover, touch ripple, cancelled presses, disabled transitions and theme changes during active animations. Settled screenshots missed these defects. | Define the affected state transitions before editing and inspect intermediate frames, cancellation and interruption as well as endpoints. |
| Custom painting, tracking and lifecycle handling were considered or introduced before native/package capabilities were fully established; tooltip packages met individual requirements but not the complete combination. | Verify the complete requirement set against the installed framework/package API and, where necessary, source. Prefer native configuration; retain only the narrow adapter required for a demonstrated gap. |
| Browser photographs failed through byte fetching because of CORS; a missing dart-define configuration separately caused loading failure. | Separate configuration, endpoint response, browser transport, image decoding and display readiness when diagnosing loading. Validate the actual launch command/platform before changing application logic. |
| Malformed individual API records initially rejected otherwise usable batches. | Establish record-level versus response-level failure policy before parsing; exercise mixed valid/invalid lists, all-invalid lists and invalid response structures. |
| Shared layout definitions created shell/page coupling; TabItem's location created a selector/group import cycle. Files also accumulated rendering and lifecycle responsibilities. | Review callers and both directions of imports/re-exports before choosing an owner. Extract a responsibility, not an arbitrary number of lines; place shared contracts below their consumers. |
| Historical implementation notes became inconsistent with later decisions, and pending features could be confused with violations. | Compare claims with the latest authorized scope and current code; label historical evidence and keep unfinished features explicitly pending. |
| Early image tests used an invalid fixture and advanced fake time before decoding completed. | Verify fixtures and synchronize with observable readiness; do not mistake test scheduling failures for application failures or solve them with arbitrary sleeps. |

### Before writing code

1. **Establish scope and baseline.** Read the affected capability scenarios, current design decisions, UI guide and latest implementation evidence. Identify the working-tree changes already present. List what may change and what must remain invariant; unfinished catalog/details work is not a refactoring defect. Resolve actual contradictions with the latest authorized decision rather than silently broadening scope.
2. **Inspect the real source of truth.** For visual changes, use the Figma plugin to inspect current component variants, state styles, dimensions, typography, colors, effects and icon scaling. Confirm the intended file/node and the actual running application/browser before comparing screenshots. If inspection is blocked, report the limit rather than claiming a match. A pure responsibility move with unchanged recipes does not require a new Figma audit.
3. **Choose ownership and dependencies.** Trace callers, imports and re-exports under G1–G7. Keep domain widgets page-owned, atomic UI independent of application state, and styling recipes beside their widgets. Reuse existing global variables. Do not split comprehensive color definitions for size alone, create hypothetical shared widgets, or introduce managers solely to shorten a file. Check whether a move needs a compatibility re-export for existing consumers.
4. **Check native/package support before adding behavior.** Evaluate requirements together, including input modes, placement/collision behavior, theme updates and lifecycle. Distinguish package-owned behavior from project adapters. Do not infer cancellation, arrow positioning or released-ripple recoloring from a package name or example. Preserve accepted adapters unless evidence supports replacing them; do not duplicate native gesture recognition, caching, focus handling or animation disposal.
5. **Identify identity and lifetime constraints.** For extraction, note widget keys and retained elements, ancestor Theme/Material/Ink/DefaultTextStyle scopes, clipping/paint order, controllers, timers and disposal. Trace callback captures and async mounted/alive guards. For discovery, preserve encounter identity separately from repeatable image IDs, append-once batches, front-of-queue prefetch, same-photo retry and the distinction between retrieved bytes and displayed-image readiness. For navigation, preserve retained views, native scroll restoration, single tab strip and existing browser/platform history.
6. **Select verification before editing.** Locate existing tests for the affected contract and identify meaningful coverage gaps. Define expected intermediate and final states for animation changes. Choose actual target-platform checks where platform behavior is involved. No standalone query proof, new architecture checker or mandatory test for every private helper is required.

### After writing code

UI checks below remain manual outside the selected Widgetbook/Alchemist screenshot coverage documented in the [catalog instructions](../../../widgetbook/README.md). Do not recreate removed per-issue Flutter UI suites. Application-contract tests remain focused on API and application-state behavior. Standalone catalog and screenshot coverage is selective, not a requirement for every UI family.

1. **Review the actual diff and consumers.** Confirm only authorized responsibilities changed, imports remain valid in both directions, and public inputs/exports still work. Check nullable-field promotion when moving local variables into widget fields. For extraction, compare the old and new rendering/animation subtrees, keys, inherited scopes, callbacks, deadlines and disposal—not just file sizes. Verify that no domain policy moved into a presentation helper.
2. **Exercise affected interaction paths.** For buttons/tabs, check applicable variants under enabled, disabled, loading, hover, focused, pressed, released and cancelled states; mouse, touch and keyboard activation; stationary-pointer enablement; and rapid repeat input. Check theme changes during ripple expansion/fade, selection timing, focus outlines, reduced motion and animation interruption. Preserve variant-specific behavior: underline tabs have no background/focus outline; gray tabs retain their accepted ripple and selection timing. Do not generalize one variant's policy to all controls.
3. **Exercise affected layout and lifecycle paths.** Check narrow/short and desktop layouts, enlarged text, overflow, rounded clipping and paint order. For crossfades, verify outgoing input/focus/semantics suppression, retained state and rapid reversal. For discovery changes, exercise ready/loading/recovery, decode failure, same-photo retry, skip without voting, refill failure with queued content, exhaustion and stale callbacks. Slow/failed votes must not block discovery. Duplicate image IDs remain valid independent encounters.
4. **Verify platform-sensitive behavior on that platform.** Browser image loading/CORS, browser Back/Forward and Android rendering cannot be established by VM widget tests alone. Use the configured build/run invocation with `--dart-define-from-file`; retain the example configuration and no URL/key defaults in code. Never print or commit secrets or bypass TLS/CORS protections. If a required environment is unavailable, report the specific unverified behavior rather than treating another platform's success as proof.
5. **Run proportional executable checks.** Format changed Dart files; run `flutter analyze --fatal-infos --fatal-warnings` and relevant behavioral tests. Run the full retained suite when a change affects shared API/application-state behavior. UI-only changes require the relevant manual checks; passing state tests does not establish visual correctness. Check whitespace with `git diff --check`. Build/run the affected target when compilation or platform integration is at issue; release APK verification remains a delivery check. Before adding a test, identify a meaningful contract not already covered by an existing scenario. Prefer extending existing coverage; do not add one case per past issue, smaller duplicates, variant matrices, or tests of helper shape/import structure. Stop repeating successful checks unless further edits or unresolved risks justify it.
6. **Reconcile and report.** Update capability specs only when authorized behavior changes; for responsibility moves, reconcile affected ownership documentation/evidence without rewriting product requirements. Keep historical test counts attached to their original runs. Record commands actually executed, failures resolved, remaining limits and pending features. Documentation-only changes require consistency/link/whitespace review, not an application test/build run. Never equate clean analysis or passing widget tests with complete Figma, browser, device or release acceptance.

Current automated coverage is in `test/api_configuration_test.dart`, `test/discovery_test.dart` and `test/appearance_test.dart`, with the shared fake transport under `test/internal/`. Discovery covers API/query/state integration, not rendered-image readiness or page gestures. The separate test/visual suite covers selected AppButton, EmptyState, FeaturedIcon, AppTooltip and HorizontalTabs sheets, plus representative native button interaction states. Navigation rendering, animation timing contracts and browser photograph display are not established by those captures. Inspect actual assertions when selecting evidence; do not claim future Storybook coverage as present verification.

## Test review criteria

Apply these criteria to proposed tests and affected existing coverage. This is a review policy, not an automated validator or a requirement to add tests for every change. Application-contract scope remains API and application-state behavior. Visual coverage uses shared Widgetbook/Alchemist sheets rather than per-property or per-issue assertions; no screenshot matrix expansion is required for unrelated changes.

| Criterion | Accept | Revise or remove |
|---|---|---|
| Meaningful contract | The test detects a violation of an agreed application/API behavior through observable outcomes. | The only justification is that this was once a bug, or that a helper/branch exists. |
| Independent expectations | Expected outcomes come from the contract and controlled inputs. | Expected values repeat production parsing, normalization or decision logic, allowing the same mistake on both sides. |
| Refactoring tolerance | Assert encounter/image identity, requests, recovery and restored preferences. | Assert exact Dart object identity, helper arrangement or serialized storage values when those details are not contractual. Implementation details are permissible only where they are themselves an explicit boundary contract. |
| Distinct coverage | Each scenario protects a meaningfully different contract or failure/lifecycle boundary. | A narrower case or assertion is already established by a broader scenario; alternate inputs merely repeat the same covered path. Parameterization does not by itself justify retaining redundant cases. |
| Reliable evidence | Fixtures represent the real input type; async assertions follow observed completion and required continuations. | Invalid fixtures pass because decoding is bypassed, arbitrary sleeps stand in for completion, or lack of an exception is presented as proof of ignored late results. |
| Honest claims | Test names and reported coverage describe assertions and configurations actually exercised. | Conditional execution claims both configured/unconfigured behavior without running both; cancellation-only assertions claim late-write prevention. |

Before adding a scenario, inspect existing coverage. Prefer extending a coherent existing scenario, removing duplicate assertions, or narrowing an overstated name. Do not add one regression case for every past issue. Preserve distinct contracts even when they share setup; avoid giant combined scenarios that obscure failures merely to lower the count. There is no target test count or requirement to preserve historical counts.

Examples from the test review: verify System preference restoration through a new provider session rather than its serialized string; compare retained encounter/image IDs rather than object identity; cover no-usable-record recovery without repeating it for an empty list when the all-invalid list already establishes it. Duplicate preservation during parsing and independent voting on repeated images protect different contracts and may remain separate.

### Widgetbook and screenshot coverage selection

Choose coverage according to the distinct presentation or interaction contract it protects and its review/maintenance cost. A widget’s existence, a previous bug or a new variant alone does not require a standalone story or screenshot test.

1. **Inspect parent coverage first.** Compare the proposed case with existing parent sheets, playgrounds and interaction captures. Avoid a second standalone child matrix when the same behavior is already protected. Retain parent composition cases that establish distinct spacing, wrapping, clipping or integration; rendering a child in a parent is not itself harmful duplication. Do not claim parent coverage for states it never exercises.
2. **Use representative cases.** Preserve distinct style/size recipes and meaningful layout or interaction boundaries, but do not cross every variant with every action count, content sample, input mode and viewport. Use representative overflow, disabled, wrapping and interaction cases when the behavior is shared. Representative coverage is a deliberate selection, not a target test count or permission to discard distinct contracts.
3. **Select each artifact independently.** A playground can be useful without grouped sheets or screenshots; manual sheets can be useful without automated baselines. Simple compositions may need only manual inspection, and implementation children may need only parent coverage. Do not require standalone stories or screenshots for every widget, helper or asset. Avoid icon-by-icon screenshot inventories whose cost grows without adding distinct behavior coverage.
4. **Match evidence to the claim.** Settled screenshots protect appearance and composition, not animation timing, transition continuity or all input behavior. Keep useful live playgrounds for those inspections rather than adding static matrices that cannot establish the intended contract. Preserve native interaction and settling mechanisms in retained tests.
5. **Record intentional scope.** Document what is retained, what is exercised through a parent, and what remains manual. Intentional omissions are not pending implementation. Update or remove obsolete baselines when coverage is authorized to change; leave unrelated matrices and production behavior unchanged.

Current examples: TabButton uses parent coverage; TabsSelect and HorizontalTabs mobile select mode are excluded while their built-in popup is incomplete; AppIcon and LoadingIndicator have playgrounds without static matrices; ThemeSelector retains its live transition playground; PageHeader has no standalone stories or screenshots; LoadingState has manual sheets without dedicated screenshot tests. AppButton retains all visual sheets but uses primary as the representative icon-only interaction hierarchy. HorizontalTabs and EmptyState retain their distinct size/style recipes with representative layout compositions. These are applications of the criteria, not a requirement to freeze the catalog permanently.

## Evidence and handoff

Each structural implementation review records:

- Exact commit SHA, or base SHA plus the reviewed working-tree diff if uncommitted.
- Applicable gate IDs, result, and concise file/symbol references supporting the result.
- Commands actually executed and their results for standard Flutter checks or focused behavioral tests, where relevant; no automated architecture checker is required or permitted.
- Semantic review findings and resolutions; unresolved integration choices explicitly marked not verified.
- Focused behavioral evidence where G4–G6 or G8 depends on runtime behavior.

Keep this evidence in the change review or an implementation gate log linked from the eventual delivery README. Do not add a second tracking system solely for these gates. Flutter formatting and analysis support code quality but do not replace ownership review. Structure and dependency enforcement remains a review responsibility; no automated boundary enforcement work is planned.
