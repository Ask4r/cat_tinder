# Working on Cat tinder

These instructions apply to this Flutter project. Work within the requested scope, preserve unrelated working-tree changes, and do not commit, publish or modify Figma unless authorized. Follow the user's latest explicit decisions when they supersede documentation; reconcile affected documentation rather than silently changing product behavior.

## Read before changing code

- [README](README.md): current implementation status and run configuration.
- [Design](openspec/changes/define-product-baseline/design.md): product flows, ownership and selected toolchain.
- [Quality gates and maintenance workflow](openspec/changes/define-product-baseline/structure-gates.md): manual G1–G8 review and before/after checks.
- [Feature plan](openspec/changes/define-product-baseline/tasks.md): implemented versus pending work. Pending items are not authorization to implement them.
- [UI guide](lib/ui/README.md): component recipes and accepted interaction behavior, when changing presentation.
- Relevant capability specs under `openspec/changes/define-product-baseline/specs/` and the latest sections of [implementation evidence](openspec/changes/define-product-baseline/discovery-implementation.md).

Earlier evidence entries describe historical stages, not necessarily current behavior. Do not treat old test counts or platform limitations as current verification. Discovery, Settings appearance and retained root-tab navigation are implemented; consult the plan for remaining catalog/details work.

## Ownership and structure

- `lib/api`: remote DTOs, handwritten parsing, Dio operations and reusable Cached Query definitions/policies. No imports from app, state or UI.
- `lib/state`: shared application data and coordination. Riverpod owns application state; Cached Query owns remote query lifecycle/cache. Application models stay with their owner, not in a universal models folder.
- `lib/ui/styles` and `lib/ui/theme.dart`: shared variables and theme foundations. Preserve the complete variable set, including unused colors, with conventional Dart names.
- `lib/ui/widgets/internal`: shared UI implementation machinery, not public design-system widgets. Keep component-specific interaction policies with their owners; internal helpers must not own application state or replace native gestures.
- `lib/ui/widgets`: reusable atomic presentation components, independent of application state. Local UI state is allowed; “stateless” does not mean `StatelessWidget` only. Accept content and presentation configuration from parents, not domain flags or DTOs. Do not turn atomic controls into app layouts.
- `lib/app/pages`: high-level views, including tabs, and their owned widgets/helpers. Keep discovery-specific rendering, recovery and prefetch helpers here.
- `lib/app/layouts`: top-level composition and coordination. Shared layout definitions must not depend on the shell or pages that consume them.
- `lib/app/widgets`: last resort for actual cross-page app-specific reuse. Do not create it for hypothetical reuse.

Use `package:cat_tinder/...` for cross-layer imports; same-layer relative imports are allowed. Review imports and re-exports in both directions. Put shared contracts below their consumers; preserve existing consumer imports with a re-export when appropriate.

Decompose by responsibility, not file length. Keep private component presentation helpers and their styles in the same file. Keep coherent state/gesture/lifecycle ownership together. Do not introduce empty scaffolding, mandatory repositories/use-cases, a DI framework, a service locator, or a new routing/query engine. The selected stack is Cached Query, Riverpod, Dio and Flutter Navigator/Router. New dependencies default to compatible stable versions; do not upgrade existing dependencies incidentally.

The `widgets` directory is grouped into `base` (AppButton and AppTooltip), `application` (tabs and their item/select controls, PageHeader, EmptyState and LoadingState), `assets` (AppIcon, FeaturedIcon and LoadingIndicator), and `internal` (shared implementation helpers). These are presentation categories, not new state or dependency layers: `application` widgets still accept their content and selection from callers and do not access application state. Raw SVG/font files remain in the project assets directory.

## Preserve product contracts

- No like counters, discovery/vote history, or image-ID deduplication. Repeated images are separate encounters; tab-navigation history is supported.
- The discovery queue determines the current image. Refill appends each execution once; advancing removes the head. Capture the decided encounter before sending its vote. Vote failure must not block discovery or trigger content recovery/retry.
- Skip malformed individual records while retaining usable records in order. Invalid response structure or no usable records enters recovery. Where a single breed is required, use the first listed breed; do not select a later breed to repair an invalid first one.
- Keep refill failures unobtrusive while queued content remains. Photograph retry reloads the same image; skip does not vote. Retrieved bytes and a displayed, decoded photograph are distinct readiness conditions.
- Keep query policy/callback wiring centralized. Do not implement another cache or request lifecycle in widgets. Native photograph bytes use Dio; browser photographs use the established Flutter HTML-image provider/cache path, not CORS-restricted byte fetching.
- Preserve retained root views, the single tab strip, native scroll restoration, existing history and crossfade behavior. Do not replace these mechanisms as an incidental cleanup.

## UI and interaction changes

For visual changes, inspect current Figma component masters, variants, states and variables using the plugin. Confirm the correct design file/node and running application before comparing. Do not infer a complete component from one screenshot or silently alter inconsistent design assets. Pure responsibility moves with unchanged recipes do not require a fresh Figma audit.

Check native Flutter/package configuration and, when necessary, source before adding an adapter. Evaluate the complete requirements together. Keep gesture recognition, focus, collision handling, arrow adjustment and animation lifecycle native/package-owned wherever possible. Preserve existing narrow adapters unless their replacement is explicitly within scope and verified.

For extractions, preserve widget keys, retained elements, inherited Theme/Material/Ink/text scopes, clipping and paint order, callback captures, timers/controllers and mounted/disposal guards. Do not move native button/ripple interaction ownership merely to shorten a build method.

Manually inspect affected transitions as well as settled states alongside the scoped screenshot coverage: hover, focus, touch press/release/cancel, disabled/loading changes, stationary-pointer enablement, theme changes mid-animation, rapid reversal and reduced motion. Preserve variant-specific policies; underline and vertical-line tabs have no base background or focus outline; unselected gray tabs have no hover fill. Theme-following ripple colors and delayed touch selection belong only to the Settings-owned ThemeSelector; shared tabs use ordinary color transitions and native ink. Use the UI guide for details; do not reintroduce Flutter UI regression suites for individual past bugs.

## Configuration

Use `--dart-define-from-file=config.json` and `String.fromEnvironment`. Keep `config.example.json`; do not add URL/API-key defaults in code or restore runtime `.env` loading. Configuration changes require restarting/rebuilding with the flag, not just hot reload.

Do not print or commit secrets, send the API key to photograph hosts, or bypass TLS/CORS protections. Diagnose configuration, endpoint responses, transport/CORS, decoding and display readiness separately before changing recovery logic.

## Verification and handoff

From the project directory, use checks appropriate to the change:

```sh
dart format --output=none --set-exit-if-changed lib test widgetbook
flutter analyze --fatal-infos --fatal-warnings
flutter test --dart-define-from-file=config.test.json
git diff --check
```

Format changed Dart files before checking. Keep automated tests focused on API contracts and application-state behavior. Widgetbook and Alchemist now cover grouped AppButton text/icon-only, EmptyState, FeaturedIcon, AppTooltip, HorizontalTabs sheets and button medium-default interaction captures (all text hierarchies, primary only for icon-only); see [catalog instructions](widgetbook/README.md). PageHeader has no standalone stories or screenshot tests; LoadingState retains manual sheets/playgrounds only; AppIcon, LoadingIndicator and Settings ThemeSelector are playground-only; TabButton is exercised through parent components. TabsSelect and HorizontalTabs mobile select mode are excluded from the catalog and screenshots while their built-in popup remains incomplete; production behavior is unchanged. Do not require every widget or every asset to have a standalone screenshot matrix. Extend shared stories and visual captures when authorized, not the removed per-issue assertion suites. Before adding a test, check whether an existing scenario already covers the contract; extend it where appropriate instead of adding a case for every past issue. Keep distinct failure/lifecycle contracts, but avoid variant matrices, smaller duplicate scenarios and tests of private helper shape or imports. Run relevant retained suites during implementation and the full suite when shared behavior is affected. Verify fixtures and observable readiness rather than adding arbitrary sleeps. Do not repeatedly rerun successful checks without further changes or unresolved concerns.

Review structure/architecture manually under G1–G8. **Do not add automated architecture linters, import-boundary validators or structure tests.** No standalone query-proof stage is required.

### Test review criteria

- Identify the meaningful application contract and the regression the test would detect. A past issue alone is not a reason to add a test.
- Assert observable outcomes: retained encounters, emitted requests, recovery or restored preferences. Avoid duplicating production parsing/normalization logic, exact Dart object identity, private helper structure or storage representation unless that detail is itself an explicit contract.
- Compare coverage with broader existing scenarios before adding or keeping a case. Remove redundant assertions and cases; extend an existing scenario when it stays coherent. Keep separate cases only for distinct contracts, not different inputs that merely repeat the same path. Do not collapse unrelated contracts just to reduce the test count.
- Use valid, representative fixtures and observable async completion. Fixed sleeps and absence of an exception do not prove completion or that late results were ignored.
- Ensure test names and reports match assertions actually executed. Do not branch expected behavior by copying production logic or imply coverage of configurations/platforms that were not exercised. Narrow the claim when appropriate rather than automatically adding scenarios.
- Judge tests by useful coverage and maintenance cost, not count. Review additions and existing affected tests against the [spec criteria](openspec/changes/define-product-baseline/structure-gates.md#test-review-criteria). UI coverage uses deliberately selected Widgetbook/Alchemist examples; an omitted standalone story or suite is not automatically pending work.

### Widgetbook coverage criteria

Keep catalog sources under `widgetbook/ui/widgets/{base,application,assets}/<component>` or their app-owned path, matching golden ownership paths. Use `sheet.dart`/`playground.dart` and shared `widgetbook/internal` helpers; do not duplicate sources for light/dark themes.

- Check parent-component sheets and interactions before adding standalone coverage. Do not repeat a child’s states when a parent already protects the same contract. Parent composition screenshots remain useful when they verify layout or integration rather than duplicate child interaction matrices.
- Prefer representative cases over exhaustive cross-products of styles, sizes, content, actions and input modes. Preserve distinct visual recipes, meaningful layout boundaries and genuinely different interactions; choose representatives for repeated behavior. Do not remove distinct coverage merely to reach a smaller count.
- Decide separately whether a widget needs a playground, grouped sheet and screenshot tests. None is mandatory for every widget. A playground-only entry, manual sheet without tests, or parent-only coverage is valid when it provides sufficient value. Do not enumerate every icon/asset in screenshot matrices merely because it exists.
- Judge coverage by the contract protected versus review and maintenance cost. Settled screenshots do not verify motion, timing or intermediate feedback; retain useful interactive previews without duplicating static tests. Do not describe intentional omissions as unfinished features.

Use actual browser/device checks for platform-specific changes. The browser photograph regression was removed with the UI suites; browser image loading now requires manual verification until replacement coverage exists. A web build does not verify Android rendering or replace an APK build. Build/run the affected platform when integration requires it; release APK validation remains delivery work:

```sh
flutter run --dart-define-from-file=config.json
flutter build apk --release --dart-define-from-file=config.json
```

Report what changed, why, checks actually run, and material unverified behavior. Do not claim visual/device/live-service acceptance from analysis or widget tests alone. Keep unfinished features pending. Update capability specs for authorized behavior changes and ownership/evidence documentation for structural changes. Use the existing evidence log rather than creating a second tracking system. Documentation-only edits need consistency, link and whitespace checks, not an application test/build run.
