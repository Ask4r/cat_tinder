# Product decisions, user flows, and engineering handoff

## Context

See [proposal.md](proposal.md) for scope and the explicit no-counter coursework deviation. The baseline began with a Flutter starter. The user subsequently authorized development-plan slice 1 (discovery), which is now implemented. Settings appearance selection and retained root-tab history/crossfades were subsequently authorized and implemented; breed details, catalog and delivery remain planned. See discovery-implementation.md for actual verification and limits.

This artifact records the agreed product behavior and engineering boundaries. The structure, toolchain and discovery query/state integration are settled and implemented. Remaining integration work concerns the planned breed catalog and contextual details, followed by full-application and release verification. The baseline documentation did not itself authorize implementation; subsequent user requests authorized discovery, Settings and navigation. The recent layout extraction and documentation reconciliations did not modify Figma files.

## Goals / Non-Goals

**Goals:** A small coherent discovery product with secondary breed learning, predictable navigation, and non-blocking voting. English copy follows the application reference. Android release APK is the required delivery target; desktop frames describe wider layouts, not an additional platform release obligation.

**Non-Goals:** Counters of any kind, saved collections, account/login, persistent anonymous identity, encounter history, discovery filters, preferences beyond Light/Dark/System appearance, matching, messaging, custom backend, guaranteed vote delivery, offline download system. Assets and detailed visual design development are outside this stage. Figma need not demonstrate interactions through a working prototype.

## Decisions

### Source of design intent

Use the Figma **Cat tinder / Application** section (33:1843), not **Main pages**, which contains earlier design-system examples and fictional profiles. Application reference frames:

| Destination | Mobile | Desktop |
|---|---|---|
| Discover | 33:2653 | 33:1844 |
| Breeds | 33:2709 | 33:1900 |
| Shared Details | 33:2757 | 33:1948 |
| Settings | 112:16607 | 111:16290 |

Retain the accepted design language as implementation proceeds. The latest reviewed Application frames omit visible counters and the separate simplified Cat details views. Unused counter library components do not authorize counting. Settings includes the explicitly approved appearance selector; other legacy Preferences content remains out of scope. Loading and error components have since been added and implemented. A working Figma interaction prototype is not required.

### Data meaning

Discovery uses images, not uniquely identified individual animals. Images have breed associations; API votes reference images. Use the first listed breed only where one identity is required, consistently across card label and its details; preserve other associations. The catalog remains independent. No breed aggregation or vote-history retrieval is needed.

### Small navigation model

Use Discover, Breeds and Settings root tabs and a shared full breed-information UI. Discover and Settings are implemented; Breeds remains disabled until its feature slice is implemented. Settings offers Light, Dark and System appearance, applied immediately and persisted when local storage is available. Discovery-origin and catalog-origin details may be separate pages sharing widgets with different data population; one route or one page class is not required. Discovery entry uses the queue-head image at navigation time and its first listed breed. Catalog entry uses the selected breed and a representative image. Both show the same complete information hierarchy, without a brief-to-full navigation step. The generic Back control returns to the entry context; the highlighted tab also follows that context. Opening or reading details does not pop the queue.

### Voting without blocking discovery

The local action accepts an encounter decision; it does not claim server confirmation. Prepare the next card/image where possible and submit the vote independently. Do not add confirmation alerts, automatic retry queues, or deduplication across encounters. This prioritizes continuity over guaranteed delivery, as requested. Like and Dislike remain equally primary actions despite different visual emphasis.

## Action hierarchy and availability

| Action | Role | Availability |
|---|---|---|
| Like / right swipe | Primary | Ready, undecided Discover card only |
| Dislike / left swipe | Primary | Ready, undecided Discover card only |
| Discover / Breeds / Settings tabs | Global navigation | Every destination, including loading/error states |
| Photograph / View breed details | Secondary | Ready Discover card |
| Select breed row | Secondary | Loaded catalog |
| Read information | Secondary | Details |
| Change appearance | Secondary | Settings; Light, Dark or System |
| Back | Contextual navigation | Details returns to its origin; roots traverse tab history |
| Retry | Recovery | Failed content operation only |
| Skip unavailable photograph | Recovery | Failed discovery photograph; no vote |

## User flows

| Journey | Path | Invariant |
|---|---|---|
| Discover and vote | Launch → Discover → card → Like/Dislike → next card | One decision per encounter; no wait for vote confirmation |
| Inspect current image | Discover photo/link → Details → Back | Same image and selected breed; no vote or advancement |
| Explore breeds | Breeds → selected row → Details → Back | Same catalog position; discovery unaffected |
| Switch activity | Any screen/state → selected tab → its root | Restore retained state; no duplicate stack or late navigation |
| Change appearance | Settings → Light/Dark/System → return | Immediate theme update; saved preference; discovery preserved |
| Recover content | Content error → Retry → content/error | Retry only failed content, never an earlier vote |
| Unavailable image | Discovery image error → Retry or skip | Retry same image; skip submits no vote |

Visible/platform Back in Details restores the origin. Root-tab changes create history entries; platform Back restores the previous entry, and browser Back/Forward restore the recorded selection. With no earlier entry, Back follows normal platform exit. A direct non-Discover root entry returns to Discover first. A Details page highlights its origin tab; selecting a tab from Details opens the root. Selecting an active root tab is a no-op. The shell retains one tab strip and all implemented root views. Per-tab PageStorageKeys restore native scroll offsets; a stable GlobalKey preserves the content subtree when the scrollable is recreated. The strip scrolls with the content. TweenAnimationBuilder drives the 200ms content crossfade, with offstage visibility derived from opacity and no manual completion flag; inactive views immediately lose input, focus, semantics and tickers. Reduced motion skips the transition.

## Acceptance and later-stage constraints

The four capability specs contain the acceptance scenarios. They cover narrow/short screens, larger text, gesture separation, asynchronous navigation, endpoint isolation, and retry. A design review establishes these paths' soundness; it does not prove running behavior. Visual asset production and prototype demonstration are not required by this review.

Implementation must support these existing assignment constraints:
- TheCatAPI `/v1/images/search` with `has_breeds=1`, `/v1/breeds`, and image voting; free-key access is assumed sufficient.
- Configurable `CAT_API_KEY` and `CAT_API_BASE_URL` via `--dart-define-from-file=config.json` and `String.fromEnvironment`, using a Git-ignored `config.json` copied from `config.example.json` (the example supplies `https://api.thecatapi.com/v1`; no in-code configuration values), with no committed keys, TLS bypass, or HTTPS downgrade. The base must be replaceable for evaluation.
- Typed data, network/JSON work separate from widgets, clear state ownership, safe lifecycle handling, and no unused scaffolding or unnecessary layers.
- Dio is selected within the assignment's allowed HTTP clients. Photographs use Flutter Image: prefetched bytes on native platforms and the HTML NetworkImage strategy on web, with ahead-of-use loading and image-specific retry.
- Predeclared gates: formatting, clean Flutter analysis, release APK build, acceptance journeys/failure scenarios, and visual/accessibility review of the eventual UI. Log actual results against commits and record genuine review findings. Automated tests are optional, not a blanket requirement.
- Preserve this baseline in commit history before principal implementation when committing is authorized. No commit or push is performed by this documentation task.
- Final delivery: repository, exact commit SHA, matching GitHub Release APK, and current screenshots/video including an error state. A custom launcher icon remains a later delivery obligation; no asset decision is made here.
- Final README has eight sections: description; completed features; known issues/unimplemented requirements (including counter omission); screenshots/video; APK link; launch/check commands and results; 5–10 sentences explaining the app written by the user without AI; implementation track/AI usage with links to specs, gate log, and review.

## Risks / Trade-offs

- No like counter → deliberate assignment deviation; do not restore it silently or claim full rubric compliance.
- Best-effort votes can be lost or have uncertain outcomes → accept this product trade-off; handle failures safely and never claim confirmed delivery.
- Prefetch cannot guarantee uninterrupted browsing during content outages → bounded loading and content-specific recovery remain necessary.
- Optional source data can be absent → show Not provided rather than infer facts or introduce another content service.
- Static Figma is not runtime evidence → later verify the specified behavior in the app; do not require Figma changes or working prototype links.

## Development sequence

The [feature-focused development plan](tasks.md) proceeds through cat discovery, discovery-origin details, the breed catalog and catalog-origin details, application-wide usability, and delivery. Integration, recovery, navigation, and relevant checks are included in their features; dependency installation and per-step validation are not separate stages. No standalone query proof or architecture-checker setup is included.

## Project-structure acceptance

[Project-structure quality gates](structure-gates.md) define ownership and dependency checks, review criteria, evidence, and pass/fail policy. They are review-only: automated structure/architecture linters and validators are excluded. Standard Flutter checks remain applicable without a separate setup stage. Query/state integration is verified within feature implementation. The gates also define the [before/after maintenance workflow](structure-gates.md#maintenance-workflow-before-and-after-code-changes), based on implementation findings: source inspection, native/package capability checks, ownership/lifetime review, proportional regression checks and documentation reconciliation.

## Selected project structure

This is a responsibility map, not a request to create empty directories. Use Dart-style snake_case names and add files only when needed.

```text
lib/
  api/
    breeds/
    images/
    votes/
  ui/
    widgets/
      base/
      application/
      assets/
      internal/
    styles/
  state/
  app/
    pages/
      discover/
      settings/
      breeds/
      breed_details/
    layouts/
    widgets/                 # only if justified by actual shared usage
```

- `api`: manually authored remote DTOs based on TheCatAPI reference, Dio endpoint modules, and reusable Cached Query definitions. Models the application operates on belong to their actual owner (state, page, or widget), not automatically here. Shared transport/query configuration may live at the API root; no extra repository abstraction is required solely for layering.
- `ui`: application styles, themes, colors, typography, and reusable atomic presentation widgets. Independence means no application-state or other-widget-state dependency, not a requirement to extend `StatelessWidget`. Local interaction state is allowed. Inputs may include narrow unmanaged content slots (actions/links) or presentation configuration such as text, size, and color. Domain flags are forbidden. Do not turn a widget into a general-purpose layout simply to move it here.
- `state`: data worth sharing across application contexts, especially the discovery queue. Global session lifetime is sufficient for this small application. Do not mirror every query result into Riverpod; keep page-local state with its page and remote query lifecycle with Cached Query.
- `app/pages`: high-level views, including tabs, and their owned models and widgets. Separate contextual detail pages may share their content widgets. The example `breed_details` directory does not require one page implementation.
- `app/layouts`: `application_layout.dart` owns shared frame/constants without importing pages; the shell imports those definitions and public page entry points. This area owns top-level application wrappers, navigation, and genuinely shared page coordination, including wrappers with no visual output. They reuse `ui`; app-level layout evolution must not require changing atomic `ui` widgets.
- `app/widgets`: last resort for widgets reused across pages that cannot honestly fit `ui` or a single page. Prefer page ownership or limited general-purpose configuration first. Do not add domain options or arbitrary layout composition merely to avoid this folder. Use `widgets`, not `components`.

The `widgets` directory is grouped into `base` (AppButton and AppTooltip), `application` (tabs and their item/select controls, PageHeader, EmptyState and LoadingState), `assets` (AppIcon, FeaturedIcon and LoadingIndicator), and `internal` (shared implementation helpers). These are presentation categories, not new state or dependency layers: `application` widgets still accept their content and selection from callers and do not access application state. Raw SVG/font files remain in the project assets directory.

## Selected toolchain and integration boundaries

| Concern | Decision |
|---|---|
| UI/runtime | Flutter and Dart; latest stable compatible versions when dependencies are installed |
| Query lifecycle | Cached Query, with its Flutter integration where needed |
| Shared application state | Riverpod only as the state manager |
| HTTP execution | Dio, organized into resource endpoint modules under `api` |
| Navigation | Root tabs crossfade retained views in one shell; Flutter Router integrates tab URLs/browser history; the application owns the tab-visit list, Navigator remains for contextual detail pages; no routing package |
| Remote model types | Manually authored from the API reference; no model-generation requirement |
| Dependency injection | No DI layer or framework |
| Component catalog | Widgetbook development entry point with selected grouped light/dark sheets and manual playgrounds |
| Visual checks | Alchemist macOS screenshots of selected shared sheets and representative button interactions; dev dependency, not application runtime |
| Versions | Default to latest stable compatible releases; depart only for a documented version-specific issue |

The current Widgetbook scope is complete. Catalog sources mirror widget ownership under `widgetbook/ui/widgets/{base,application,assets}` and app-owned paths, with shared catalog-only helpers in `widgetbook/internal`. See the [catalog instructions](../../../widgetbook/README.md) for retained coverage and the [coverage-selection criteria](structure-gates.md#widgetbook-and-screenshot-coverage-selection) for maintenance policy. Playground, sheet and screenshot coverage are separate choices, not requirements for every widget. Settled screenshots do not establish motion, page-flow or browser/device acceptance. The incomplete select popup remains excluded; future features and full-application verification remain pending.

The implementation resolves versions in pubspec.yaml and pubspec.lock. Subsequent dependency changes follow the stable-compatible policy. Do not reopen these package selections merely because some integration code is needed.

Query definitions under `api` must permit centralized success/error/lifecycle callbacks and integration with externally owned application state. Callbacks are not to be repeated in widgets or retrieval call sites. Cross-layer state updates should use an explicit integration boundary, not require API modules to know UI widgets. Discovery now wires the state owner’s callbacks into API query definitions once; `state` imports `api`, and `api` never imports state or widgets. See [implementation evidence](discovery-implementation.md) for the selected lifecycle policy and verification limits.

Use the query toolchain for shared in-flight work, caching, retry/refetch policy, and result lifecycles. If a missing feature needs repeatable configuration or an adapter, declare it once with the reusable query definition or shared integration. This is acceptable when ordinary call sites do not need to make error-prone lifecycle decisions. Do not manually rebuild a query engine or use Riverpod as a second query engine.

Navigation cancellation is preferred when work no longer has a consumer, but correctness matters more than small network optimizations. A different lifecycle policy is acceptable if justified by the selected engine, with no stale state writes, unintended repeated requests, or unhandled failures. Cached Query selection does not establish automatic Dio cancellation: observer lifetime, shared consumers, cancellation tokens, and subsequent reuse require checks during feature implementation, not a standalone proof. Leaving one screen must not invalidate work still needed by another consumer or the shared queue.

Vote mutations remain independent, best effort, and without automatic retry. Content-query retries/refetch defaults must be configured so they do not replay votes, exceed the visible loading budget, or reset successful application state.

## Discovery queue ownership

The shared application state owns an ordered queue of image entities; its head is the current image. No independent mutable current-image copy, encounter history, duplicate-image filter, or explicit queue capacity is required. A deliberate vote captures the head image for submission and pops that encounter once. Refill appends batches rather than replacing the queue. A low-water trigger replenishes it; the threshold and batch size are implementation tuning choices, not new product features.

Prepare actual image content near the queue head, not just API metadata. Background refill failure leaves usable queued cards available; only exhaustion without usable content requires blocking loading/recovery UI. Image-specific failure still offers same-image retry or skip without voting.

Queue refill is an application command consuming a retrieval result. Ensure each successful refill execution appends its batch once; remounting, cache replay, or background refetch must not append that same execution repeatedly. This is execution-level correctness, not suppression of repeated image IDs: repeated images in separately returned records remain legitimate encounters. Parallel refill triggers must not accidentally launch redundant requests. A failed or cancelled attempt must leave refill retryable.

Discovery-origin details retain the head image identity captured on entry. The queue remains accessible across contexts, but a details page must not silently switch images because asynchronous state changes. No replacement image is fetched just to open it. Catalog-origin details do not depend on the queue image.

## Remaining implementation decisions and checks

No unresolved product choice blocks the baseline. Discovery query/state integration is implemented and tested; the standalone query proof is obsolete. Extend and verify that integration within the planned catalog and details features. The following work remains, without reopening settled decisions:

- Extend the implemented session-owned query integration to future features as needed. Review navigation consumers when catalog/details are added; discovery callbacks, sharing, and session cancellation are covered by the current tests.
- Reuse the centralized query policies when adding future endpoints. Discovery refill consumption and failure recovery are implemented; navigation across future pages still needs runtime checks.
- Tune the initial discovery settings if actual-device evidence warrants it: batches of 10, refill at three remaining, and photograph-byte prefetch for the first three entries. Native platforms render prefetched bytes with Image.memory; web uses Flutter’s HTML NetworkImage strategy and image cache to display cross-origin photographs without CORS byte fetching. No explicit queue capacity is imposed.
- Confirm available free-key API fields when implementing handwritten DTOs. Design sample Coat/History/flags are not guaranteed API data. Use Not provided for missing values, including unknown booleans; never manufacture source facts or add another service.
- Complete responsive/accessibility verification across future catalog and details views, implement their contextual Navigator behavior, and verify delivery gates and release artifacts. Current Discover/Settings UI is accepted for this stage; its scrolling and tab-history behavior are implemented and tested. Full-application acceptance and delivery assets remain pending.

Do not treat OpenSpec artifact completeness as authorization to implement or archive the product change.

### Platform asset generation

Use `icons_launcher` and `flutter_native_splash` as development dependencies, configured by the root YAML files and invoked through `tool/generate_branding.sh`. Packages own asset resizing and splash generation; the narrow compatibility patch preserves existing native system backgrounds, window policies and web metadata. Startup remains first-frame-driven, with no runtime hold. Linux desktop packaging and its icon, plus the web Apple touch icon, remain checked-in because the selected generators do not cover those existing outputs without changing packaging. See [branding sources](../../../assets/branding/README.md).
