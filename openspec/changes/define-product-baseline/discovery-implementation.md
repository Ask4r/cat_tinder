# Discovery implementation evidence

Current scope: development-plan slice 1, subsequently authorized Settings appearance selection, retained root-tab navigation, and the completed selected Widgetbook/Alchemist scope. Earlier sections below record historical implementation stages and their checks; later decisions supersede them. Current behavior is defined by the capability specs and lib/ui/README.md. Reviewed working-tree changes against base commit `ac42237b75552e96431957cdc1aca472d9aacfa6`; no commit or publication is performed by this task.

## Implemented behavior

- Random image batches with `has_breeds=1`, first-listed breed identity, and preservation of all returned breed associations.
- Session queue with unique encounter numbers, no image-ID suppression or discovery history, batch size 10, low-water refill at three entries, and photograph prefetch for the first three images (native bytes; browser HTML-image cache).
- Like/Dislike buttons and horizontal swipes capture the decided image, advance immediately, and attempt independent +1/-1 votes. Rapid input targeting an old encounter cannot decide it again. Failed votes do not produce UI errors or retries.
- Initial/refill recovery, same-image retry, and skip without voting. Refill errors remain hidden behind usable queued content until exhaustion. Malformed or unusable records within a response list are skipped individually; valid records retain their order and duplicates. Invalid response structures and batches with no usable records are recoverable failures. Photograph loading failures retain the existing same-image retry/skip behavior.
- Missing/rejected API access has user-readable recovery without exposing credentials. Photograph requests use a separate Dio client without the API-key header. Android Internet permission and macOS outbound-network entitlement are enabled.
- Discovery styling follows the inspected Figma reference. Catalog and detail controls are visibly unavailable because slices 2–3 are not implemented; this is not a claim of full navigation-spec completion.

## Integration decisions

`state/discovery.dart` owns the global application-session queue and constructs API query definitions with callbacks once. The dependency direction is `state` → `api`; no API module imports application state or widgets. There is no DI layer, service locator, or architecture validator. The optional ordinary constructor argument allows tests to use Dio's controlled transport adapter.

Cached Query owns query state/cache and shares photograph requests. Refill is an explicit `refetch`, and its success callback consumes each execution once. The application-level refill guard prevents overlapping refill commands; it does not rebuild a generic query lifecycle. No polling, resume refetch, automatic retries, or persistent storage are enabled. Votes use independent Cached Query mutations with no invalidation or resubmission.

Discovery remains a consumer throughout the application session, so leaving its widget does not cancel its useful queue work. This follows the agreed global state lifetime. At session disposal, Dio requests are cancelled and late callbacks are ignored. API/native byte requests have a six-second total deadline with transport cancellation; native image decoding has a three-second readiness deadline. Web photographs have a nine-second display-readiness deadline. Initial metadata, photograph retrieval, and decoding therefore have a nominal combined budget of 15 seconds, excluding frame scheduling. Native photo queries are fresh for five minutes and retained for 30 seconds without consumers; the queue holds prepared bytes only for active encounters. On web, the page preloads the first three photographs using Flutter NetworkImage with WebHtmlElementStrategy.prefer, and displays that same cached provider through an HTML image element. No Dio byte request is made for web photographs. Voting waits for the displayed image frame; retry evicts that image provider and reloads the same URL. Flutter owns the image cache in both cases. No image replacement occurs on retry.

## Checks and limits

Focused tests use the actual Cached Query/Riverpod/Dio integration with a fake Dio HTTP adapter; they do not contact the live service. Tests cover append-once overlapping refill, credential isolation, delayed/failed votes, stale encounter input, exhaustion and retry without vote replay, photograph retry/skip, repeated IDs, unusable first breed, session cancellation, narrow layout, enlarged text, vertical-versus-horizontal gestures, missing configuration, and bounded timeout recovery.

The first widget-test run exposed an invalid PNG fixture and fake-time advancement before asynchronous decoding completed. The fixture and scheduling were corrected. Large-text checking exposed header/tab overflow; flexible text layout fixed it. No automated architecture rules were introduced.

Standard-check results are recorded below after the final run. Android release verification is blocked by the missing local Android SDK; no SDK installation was attempted. No configured real API key was supplied for a live-service run, so live photographs/vote delivery and actual Android-device behavior remain unverified. A web release compilation is supplemental evidence, not an APK substitute. Full visual acceptance and cross-page navigation remain future feature work.

## Structure review

- G1–G2: API DTOs/parsing are under `api`; theme is under `ui` and imports no application state. No domain widget was forced into `ui`.
- G3: the shell belongs to `app/layouts`; discovery card/recovery widgets remain page-owned. There is no unused `app/widgets` scaffold.
- G4–G6: Riverpod owns the encounter queue; Cached Query owns request/cache behavior. State wires callbacks once. Tests cover refill consumption and vote isolation. Future navigation consumers are not yet verified.
- G7: selected toolchain only, no routing/DI/architecture-checker additions; the Cupertino font dependency is retained for Flutter’s adaptive defaults.
- G8: discovery contracts are implemented within this slice. Details/catalog/global navigation acceptance remains pending and is not reported as passed.

## Final command results

- `dart format --output=none --set-exit-if-changed lib test`: passed, no changes needed.
- `flutter test`: 11 tests passed.
- `flutter analyze --fatal-infos --fatal-warnings`: passed with no issues.
- `flutter build web --release`: passed (supplemental compilation).
- `flutter build apk --release`: blocked before build because no Android SDK is installed.
- `git diff --check`: passed.
- `openspec validate define-product-baseline --strict`: passed.

The build is not published. API-key-backed live service checks and an Android release build remain outstanding environment-dependent verification.

## Web CORS correction

Downloading CDN image bytes with Dio requires the image host to grant CORS access. The browser display path now uses Flutter’s supported HTML image strategy instead, with no proxy or disabled browser security. API requests and native photograph requests still use Dio. HTML images do not support capture by Flutter screenshot widgets; this is a Flutter platform-view limitation, not a reason to restore byte fetching.

Browser regression reproduction (two terminals from the project directory):

```sh
python3 -m http.server 8767 --bind 127.0.0.1 --directory test/fixtures
```

```sh
flutter test --platform chrome test/web_photograph_test.dart
```

The fixture server is test-only, serves no API credentials, and intentionally sends no CORS headers. The test first confirms the browser rejects a Dio byte request, then checks that the same cross-origin photograph renders through the HTML path and allows a voting swipe. The fixture URL is test data, not an application configuration default.

CORS-fix verification: the Chrome regression test passed; all 11 native tests passed (the browser-only test is skipped on the VM); strict Flutter analysis and the release web build passed. The temporary fixture server was stopped after verification.

## Figma visual alignment

The live local Figma plugin supplied the discovery frames (`33:2653` mobile and `33:1844` desktop), component variants, resolved tokens, and original SVG vectors. Figma was read only. Inter is bundled with its OFL license; SVGs are rendered with flutter_svg. The brand tokens retain the source document's Display P3 color space.

The implementation now uses the measured type sizes and line heights, 1280px desktop frame, 480px desktop card, 300/360px photograph heights, 16/24px card padding, tab spacing, borders, radii, and button effects. The 768px responsive breakpoint is an implementation choice between the supplied mobile and desktop frames. Loading and recovery use the same typography and icon system. Breed navigation remains unavailable in this implementation stage and retains disabled styling.

Mobile (390×844) and desktop (1440×960) Flutter renders were compared with plugin exports using a test photograph; a layout regression test checks the measured card geometry. Existing narrow-screen, enlarged-text, vote, queue, recovery and browser CORS checks continue to apply.

Visual-alignment verification: all 12 native tests passed, including the mobile/desktop geometry test; the Chrome CORS regression passed; strict analysis, release web compilation, and whitespace validation passed. The temporary screenshot harness and fixture server were removed/stopped after review.

## Inherited styling variables and implementation reference

The initial static token mapping has been replaced by `UiVariables`, an inherited Flutter theme extension. Private palette primitives feed semantic color properties; typography uses the named text/display size scale, spacing uses a shared unit, and shadows/insets are complete effect recipes. Component styles resolve the active theme. Button style composition, geometry and motion live in the button widget file; there are no separate component-style files. Application/container dimensions belong to the application layout. `lib/ui/README.md` documents usage, scoped overrides and the pinned Untitled UI React CSS/component references.

Figma values remain authoritative. Per the user’s preference, buttons use native Flutter interaction handling, ripple and easing. Shared styling remains declarative; custom focus/inset painting and manual state observation have been removed. Reduced-motion support remains. Figma and application data behavior are unchanged.

Verification: all 15 native tests passed across the regression and scoped-theme runs. The scoped-theme test verifies colors, typography, spacing, radii, complete shadows and live updates without sibling leakage. Mobile/desktop geometry, voting, recovery, keyboard and reduced-motion checks passed. Strict analysis, release web compilation and whitespace validation passed.


The color definitions now retain the complete React CSS catalog: all 330 source color/property-variable names, imported Tailwind primitives and 317 dark-mode overrides, including unused colors. Figma palette overrides remain explicit. Alias resolution preserves dependencies when a primitive or semantic variable is overridden. No dark-mode UI was added. Styling usage is documented under `lib/ui`.

Full-catalog verification: 18 tests passed across the regression and color-resolution runs, including resolving every exposed color in both modes and cascading primitive overrides through aliases. Strict analysis, release web compilation and whitespace validation passed. The reference's dark-only `background-color-border-tertiary` property alias is also exposed in Light, pointing to the same semantic border role.


Typography naming now mirrors the design system (`textXs`–`textXl`, `displayXs`–`display2xl`). Components select weight explicitly; Flutter title/body/label roles are confined to the native-theme adapter. The former `_typography` TextTheme definition has been removed.


The full color catalog now uses typed lowerCamelCase Dart properties and named `copyWith` parameters. CSS string identifiers, `operator []`, the runtime lookup registry and the separate resolver file were removed. Alias getters directly reference their source properties, preserving primitive-to-semantic override behavior. The retained CSS reference is provenance, not the application API.

Typed-color verification: all 17 behavioral/widget tests passed, including named primitive overrides cascading through semantic/property aliases and scoped theme updates. Strict analysis and whitespace validation passed. Catalog completeness remains 622 properties; runtime string-resolution tests were removed with the runtime resolver.

Button simplification: AppButton is now a stateless wrapper around FilledButton, OutlinedButton and TextButton. Flutter owns interaction state, keyboard handling, ripple and animation. ButtonStyle declares the shared typography, geometry, state colors and borders; a standard decoration retains the outer shadow. Manual state listeners, custom tweening and focus/inset painters were removed. The subsequent visual refinement below restores a bevel approximation using standard decorations. All 18 tests passed, including native hover/keyboard/disabled behavior, geometry and a regression for interpolating extended-palette colors during native theme animation.


Button visual refinement: native buttons still own all interaction state. Their backgroundBuilder uses standard Ink/BoxDecoration layers to approximate the primary inset outline, upper highlight and lower edge without a custom painter. A built-in ColorTween supplies the 100ms fill transition, disabled under reduced motion. Transparent hover overlays preserve the exact secondary hover fill; native pressed overlays and ripples remain enabled. Decorations do not change content geometry.

Live debug-browser comparison corrected desktop density (40px instead of 48px), loose decoration constraints that shifted content, icon opacity (60%), and the project brand palette’s P3/sRGB mismatch. Primary highlighting now uses a standard gradient ShaderMask over the rounded stroke; native buttons retain interactions. The initial page screenshot was scrolled, which explained the clipped navigation without requiring a layout change.

## Discover decomposition — 2026-11-12

Reviewed uncommitted changes against base `ac42237b75552e96431957cdc1aca472d9aacfa6`. This review covers the responsibility moves under `lib/app/pages/discover` and the corresponding test imports, not all pre-existing working-tree changes.

`discover_page.dart` owns provider integration, web prefetch coordination and page composition. `discovery_card.dart` owns encounter-local readiness, decode deadlines and gesture/exit animation; `card_tilt.dart` retains the rotational model. `discovery_card_footer.dart` owns breed copy and responsive decision controls. `discovery_status.dart` owns domain loading/recovery messages, actions and surfaces. `card_foreground_column.dart` owns the page's paint ordering, while `web_photograph.dart` supplies the shared HTML image-provider configuration used by the page and card.

Ownership/dependency review: G1–G3 pass for these moves. All extracted pieces remain Discover-owned; no speculative shared widgets, remote models in UI, or cross-page implementation imports were added. Cross-layer imports use package paths. G4–G6 pass for preservation of existing ownership: queue/query orchestration is unchanged, and card interaction state remains local. G7 passes: no dependencies, scaffolding, DI, or additional styling abstractions. G8 passes for the implemented discovery behavior covered by the existing regression suite; future details/catalog flows remain outside this stage. The cohesive button recipe and complete color catalog remain intact.

Verification: `dart format lib/app/pages/discover test`; `flutter analyze --fatal-infos --fatal-warnings` (clean); `flutter test` (41 passed, one browser-only CORS test skipped on the native runner). Existing tests cover card motion, decision submission, queue recovery, loading/empty layouts, theme transitions, narrow screens and larger text. No new architecture validators were introduced. Browser CORS behavior was not re-executed in this refactor.

## Figma UI audit — 2026-11-12

Read the current Discover, Breeds, Breed details and Settings sections through the local agent plugin, including shared navigation, button, loading, empty-state and featured-icon definitions. The implemented Discover UI retains its card/image sizes, loading-state geometry, typography and featured icons. Updated the application tabs (including the unavailable Settings destination), their brand underline token and native hover handling, main bottom spacing (48px), mobile failed-photo padding (16px), link-button padding/size typography and trailing-icon capability, and whole-button disabled opacity. Application compositions remain under app; the domain-independent tab control belongs to ui/widgets. Existing gestures, queue and request behavior remain unchanged.

The new Breeds cards/request states, updated details views and Settings appearance selector were inspected as future-feature designs; they were not implemented as part of synchronizing current widgets. Failed-photo Figma variants show enabled vote actions; runtime continues to disable them as required by the product contract. Tab focus variants currently render identically to default and need a distinct design treatment. Figma was not modified.

Validation: strict Flutter analysis clean; native suite 41 passed and one browser-only CORS test skipped. Four temporary rendered-preview checks passed, with mobile recovery visually compared against Figma; preview test removed afterward. Settings remains a disabled navigation placeholder pending feature scope.

## Settings implementation — 2026-11-12

Following explicit scope approval, Settings is implemented rather than a placeholder. Its responsive layout follows Figma nodes 112:16607 and 111:16290. The shared TabButton adds the gray variant. Settings owns copy and layout; state/appearance.dart owns the preference; main maps the domain enum to ThemeMode. Shared preferences 2.5.6 retains the choice, restored before first render. Serialized writes preserve the final rapid selection, and storage failures leave session selection usable. The platform-interface package is a direct test dependency for the official in-memory preferences backend.

Navigator pushes Settings over Discover. Discover selection and platform Back restore the retained route; selecting active Settings is a no-op. The queue and current card remain intact. No routing or DI framework was added.

Validation: rendered mobile/desktop previews inspected; 44 tests passed, one browser-only CORS test skipped; strict analysis clean. Tests cover all theme modes, System brightness changes, navigation preservation, and save/restore after rapid selections. This supersedes the earlier audit's Settings-placeholder status.

## Complete horizontal tabs — 2026-11-12

Implemented the complete Horizontal tabs family from Figma 29:1007, its tab base 29:998 and select base 108:8539. HorizontalTabs owns all five group styles, two sizes, two width modes and two breakpoint variants. TabButton supports all six base styles with native interaction states; TabsSelect uses the native dropdown and the exported chevron. Native button and dropdown lifecycles remain intact. The application shell and Settings now consume the group component; their chosen row variants preserve the current application designs on mobile. Shared shadow-sm effects were added to the global variables, with copy/interpolation support.

Rendered the style/size gallery and inspected it against Figma. All 40 group combinations passed selection and disabled-item checks. The full suite passed 85 tests with one browser-only CORS test skipped. No domain state or page composition was moved into the UI components.

## Remaining used component families — 2026-11-12

Audited the current component masters through the local Figma agent plugin. AppButton now exposes all five sizes and hierarchies, including loading; AppIconButton shares its recipe for the three icon-button hierarchies. Native button interactions remain intact. AppTooltip supports all seven arrow placements with optional supporting text, retaining native Tooltip lifecycle and accessibility. FeaturedIcon implements all 44 size/style/color variants; EmptyState supports all three sizes. LoadingIndicator is reused inside loading buttons. PageHeader is shared by Discover and Settings, while the branded application header remains an app layout. Figma was not modified.

Coverage matches the component variant inventory: buttons 125, icon buttons 75, tooltips 14, featured icons 44, empty states three, and simple page headers two with identical recipes. Existing stable primary-button geometry is retained where small/medium Figma masters disagree between default and focused inset padding. Underline/line tabs still reflect the design's indistinguishable focus treatment. Tooltip placement is viewport-clamped without automatic arrow flipping.

Validation: inspected rendered component galleries and tooltip previews against the design. The native suite passed 89 tests with one browser-only CORS test skipped. Added matrix checks for button loading/disabled activation and geometry, icon-button semantics and sizes, all featured-icon variants, all empty-state sizes, and native display/dismissal of all tooltip variants. Strict Flutter analysis is clean. After header extraction, the Settings/navigation and responsive Discover layout regressions also passed (three tests).


## Forui tooltip integration — 2026-11-12

Replaced super_tooltip with Forui 0.27.7. AppTooltip is a stateless styling/semantics wrapper again. Forui owns hover, long-press start/end, dismissal, placement, flip/slide collision handling and arrow rendering. The only positioning adapter supplies fixed Figma spacing before package collision handling: 14px body spacing (8px edge-to-tip gap plus 6px arrow) and a 20px corner inset. All seven arrow choices, with and without supporting text, remain available. Target-aligned arrows adapt after collisions rather than retaining a misleading fixed inset. Earlier package limitations described above are superseded by this integration.

The dependency adds Forui, forui_lucide and sugar, and resolves meta to 1.19.0. App theme tokens remain authoritative; no other Forui controls or theme presets are adopted. Existing gesture timers and controller ownership were removed from AppTooltip.

Validation: strict Flutter analysis clean; 94 tests passed with one browser-only CORS test skipped. Geometry checks cover all arrow alignments with and without supporting text in LTR/RTL, exact edge gaps and corner insets, eight viewport-edge positions on 320px screens, and supporting text at 2× scale in both themes. Actual package-generated arrow paths are checked after collision adjustment. Existing hover, tap activation and hold/release timing regressions pass.

## Discovery record filtering — 2026-11-12

Reviewed this filtering change in the working tree against base `ac42237b75552e96431957cdc1aca472d9aacfa6`. The user clarified that malformed individual records must not reject an otherwise usable response. ImageQueries now filters unusable parsed images as well as non-object entries, preserving valid records in response order and retaining duplicate IDs. Non-list responses and lists with no usable records retain the existing recovery path. An invalid first breed never causes selection of a later breed. Existing queued content and photograph retry/skip behavior are unchanged; no UI files changed.

The content-recovery, cat-discovery and breed-information specifications now agree on this policy. Applicable gates G1, G5, G6 and G8 pass for this change: parsing remains API-owned, query policy stays centralized, queue orchestration is unchanged, and focused tests verify filtering, order, duplicate encounters, failed-batch retry and vote isolation.

Validation: formatting of changed Dart files passed; strict Flutter analysis passed; the complete suite passed 122 tests with one browser-only test skipped. No live API, release build or browser run was performed for this change. The OpenSpec CLI was unavailable on PATH, so its validator was not run; the changed scenarios were reviewed directly.


## Shared layout extraction and documentation reconciliation — 2026-11-12

Reviewed this change in the working tree against base `ac42237b75552e96431957cdc1aca472d9aacfa6`. ApplicationLayout and ApplicationFrame moved unchanged into app/layouts/application_layout.dart. The shell, header and page consumers import that file directly; the shared definitions import no pages or shell, removing the composition dependency cycle. No UI recipe, dimensions, state, history or animation behavior changed.

Current proposal/design/navigation documentation now includes the authorized Settings scope and three root destinations, while retaining details/catalog as planned work. The styling guide now describes mouse/touch ripple selection, delayed gray-tab selection fill, focus outlines on non-underline variants, tooltip hover delay and the new layout owner. Historical verification entries above remain historical; current root navigation uses retained views, a single tab strip, native PageStorage restoration and TweenAnimationBuilder-derived visibility, not pushed Settings routes. The unused cupertino_icons dependency has been removed, superseding the early dependency note.

Applicable G1–G3 and G7 pass by ownership/dependency review; G4–G6 are unchanged. G8 passes for the affected implemented behavior: the full suite passed 122 tests with one browser-only test skipped, including layout geometry, retained views, scroll positions, history, crossfade and reduced motion. Strict Flutter analysis, formatting and whitespace checks passed. No live browser/Figma review or release build was performed for this responsibility-only extraction. OpenSpec CLI validation remains unavailable on PATH.

## Discovery photograph extraction — 2026-11-12

DiscoveryPhotograph now owns photograph rendering, decode readiness/deadlines and loading/retry/skip presentation under app/pages/discover. DiscoveryCard consumes its readiness callback and retains voting gates, gestures, tilt and exit animations. Image-provider selection, browser retry eviction, dimensions, clipping and recovery behavior are preserved. Buttons are unchanged.

Validation: strict Flutter analysis passed; the full suite passed 123 tests with one browser-only test skipped. A focused regression verifies decode failure, retry on the same mounted card/photograph, disabled voting until decoding completes, and voting after recovery. Existing card motion and layout tests pass. No live browser/Figma review or release build was performed for this extraction.

## Component and discovery decomposition — 2026-11-12

Subsequent responsibility-only changes extracted private background/content helpers within AppButton and TabButton, consolidated icon-only semantics, and retained the existing native button/ripple adapters and interaction-state owners. DiscoveryLoading and DiscoveryRecovery now share a private status frame with explicit padding differences. TabItem lives in ui/widgets/application/tab_item.dart, imported by both tab consumers and re-exported from horizontal_tabs.dart to preserve callers. This removes the group/selector import cycle.

DiscoverPage retains provider observation and page composition. Its page-lifetime DiscoveryWebPrefetcher owns the existing front-three URL bookkeeping and post-frame browser cache warming, using the page context's mounted guard. DiscoveryStage owns card/loading/recovery selection and the unchanged AnimatedSwitcher, encounter keys, outgoing-card opacity, stacking and input/semantics suppression. DiscoveryPhotograph continues to own display readiness/recovery; DiscoveryCard owns motion and voting gates. Settings was not changed. These moves introduce no query manager, shared app widget or new product behavior.

Validation from the implementation runs: strict Flutter analysis and whitespace checks passed; the full suite passed 123 tests with one browser-only test skipped after both the button and final discovery decompositions. Native button/ripple adapter definitions were also compared with their pre-extraction versions. No new browser/device/Figma acceptance is claimed. G1–G8 were reviewed for the affected ownership and implemented behavior; pending catalog/details flows remain pending.

## Maintenance prechecks and follow-up checks — 2026-11-12

Reviewed the implementation history, current source and regression assertions against base `ac42237b75552e96431957cdc1aca472d9aacfa6`. The maintenance workflow in structure-gates.md now records observed sources of rework and the checks to perform before and after changes: complete design variants, transition/interruption coverage, native/package capability verification, platform/configuration diagnosis, record-level recovery, dependency ownership and documentation scope. This is review guidance within existing feature work, not a new implementation stage or automated architecture enforcement.

This update changes documentation only. Validation consists of consistency review against the current decomposition and pending tasks, local link/test-path checks, and `git diff --check`; no Flutter test or build was rerun for the documentation update. Earlier test results above remain evidence of their respective code changes.

## Test scope reduction — 2026-11-13

The user deferred UI testing to future Storybook work. Removed 17 suites covering component variants, colors/themes, geometry, tooltips, ripple/focus/hover, card motion, photograph rendering, page interaction and navigation/scroll/crossfade UI. Removed the browser photograph fixture as well; the browser instructions and results above are historical and no longer describe an available test. Storybook coverage is not yet implemented. Application code and behavior were not changed.

Retained three suites for API configuration, appearance persistence and discovery API/query/state integration. Folded the standalone invalid-first-breed case into the mixed-batch filtering scenario, removed the duplicate breed-preservation assertion from the prefetch scenario, and removed null-top-level response testing where the existing non-list response already exercises the same structural failure/retry path. Kept empty versus all-invalid batches as distinct data contracts. Repeated IDs in filtering and voting remain separate assertions of preservation versus independent encounter actions; the latter also verifies vote values. Queue/refill coordination, key isolation, nonblocking failed votes, recovery/retry, skip and session cancellation remain covered.

AGENTS.md, README, maintenance gates and the feature plan now describe the reduced test scope and pending Storybook work. Manual UI/platform checks remain necessary, and no automated UI coverage is claimed. Historical run counts above are unchanged.

Validation: formatted the changed Dart test, strict Flutter analysis passed, and the full retained suite passed 12 tests with no skips. Whitespace and current test-reference checks passed. No browser/device/UI run was performed for this test/documentation-only change.

## Remaining contract-test cleanup — 2026-11-13

Removed the redundant empty-batch case; all-invalid batches and invalid response structure still cover recovery. Refill assertions now check encounter/image identity instead of Dart object identity and verify the queued encounters survive a failed refill before consuming them. The delayed-vote test observes the actual Dio failure and drains its asynchronous continuations rather than sleeping for 10ms. Repeated-image voting now receives valid photograph bytes. Removed the duplicate encounter-uniqueness assertion from mixed-batch parsing.

The disposal test now claims only the cancellation it directly asserts and drains pending work without a fixed sleep; it does not claim independent proof of ignored late state writes. The configuration test explicitly verifies missing configuration/no defaults in an unconfigured test run instead of duplicating URL parsing/normalization and conditionally claiming configured behavior. Credential isolation remains covered against actual photograph requests. Appearance persistence now verifies System restoration through a new provider session rather than inspecting the serialized value.

No scenarios were added and application code was unchanged. Formatting, strict analysis, the full retained suite (11 tests, no skips) and whitespace checks passed. README documents the configuration-test invocation and coverage limit. No UI/browser/device verification was performed.

## Grouped button screenshot testing — 2026-11-13

Authorized Widgetbook 3.25.0 and Alchemist 0.14.1 as dev dependencies. widgetbook/ui/widgets/base/app_button/sheet.dart builds the actual AppButton in 125 combinations (five hierarchies, five sizes, default/leading icon/trailing icon/disabled/loading) shared by the scrollable light/dark catalog and full-sheet capture. The visual runner uses native mouse input and keyboard traversal on medium/default examples for each hierarchy, recording padded cell crops instead of duplicating stories or asserting internal styling properties. Two grouped tests produce 22 PNGs: two full sheets and 20 hover/focus crops.

Reference environment: macOS, Flutter 3.47.8, DPR 1, bundled real fonts/SVGs, shadows enabled, exact comparison; text-obscuring CI goldens disabled. Assets are preloaded and frames are advanced explicitly because loading animations never settle. The harness required taller cells and an explicit application theme on its MaterialApp keyboard-navigation wrapper; those harness issues were fixed before regenerating and comparing baselines. Inspected the full light/dark sheets and representative hover/focus crops for rendering problems. Initial baselines record the current UI, not a fresh Figma approval. Other component families, icon-only buttons, browser/device rendering and page flows are outside this initial screenshot coverage.

Validation: strict analysis passed; baseline generation and subsequent comparison passed; full suite passed 13 tests (11 application contracts plus two visual tests). Widgetbook web compilation passed. The build emitted a missing optional Cupertino font warning from tooling and Wasm dry-run compatibility warnings; no Cupertino dependency or production UI change was introduced to suppress them. Documentation links/whitespace reviewed. The catalog was compiled, not browser-interaction audited. Production lib/ files are unchanged; generated platform registrations now include Widgetbook's transitive url_launcher plugin. See widgetbook/README.md for launch, test, baseline review and platform limitations.

## AppButton hierarchy API cleanup — 2026-11-13

AppButton now has one non-nullable hierarchy selector, defaulting to primary. Removed the public primary/link aliases and fallback precedence. Migrated all application consumers to explicit matching hierarchies, including the previously implicit secondary Dislike and Skip photo buttons; AppIconButton already supplies its own hierarchy. The playground exposes the same non-nullable selector with primary initially selected, without compatibility toggles. Its icon-only validation follows the simplified constructor. UI recipes, input handling, transitions and existing application appearance are unchanged.

Validation: formatting, strict analysis, all 13 tests (including comparison against unchanged light/dark sheet and hover/focus baselines), Widgetbook web build and whitespace checks passed. No new test scenarios or baseline updates were needed. Updated the UI and catalog guides to describe the actual public interface.

## Link-button hover correction — 2026-11-13

Both link hierarchies now keep their fill and native overlay transparent in every state, including focus and touch press. Their native hover state resolves an underlined text style; the existing focus outline and foreground-color transitions remain. The existing splash selector suppresses link ripples without introducing gesture handling. Other button hierarchies are unchanged.

Validation: formatting, strict analysis, all 13 existing tests and whitespace checks passed. Updated the existing grouped screenshots and inspected representative light/dark link hover and focus captures. No new scenarios were added; no fresh Figma or device acceptance is claimed.

## Grouped pressed-button captures — 2026-11-13

Extended the two existing light/dark screenshot tests with mouse-held and touch-held captures of each hierarchy's medium/default example. Native pointer events select the device and pressed state; captures occur 200ms after pointer down, followed by release and feedback cleanup. No production code or forced widget states were added. The suite now produces 42 images, including 20 pressed captures. Full-sheet loading phases were refreshed because the deterministic input sequence is longer.

Inspected all pressed captures together: mouse retains hover appearance; touch renders native ink for non-link buttons; links remain background-free. The tertiary touch ripple retains its existing theme tint. These snapshots document current behavior, not new Figma or device acceptance. Formatting, strict analysis, baseline generation, subsequent screenshot comparison and whitespace checks passed.

## Settled screenshot timing — 2026-11-13

Replaced estimated capture/release delays with Flutter pumpAndSettle, advancing frames in 16ms increments until no frame remains scheduled, with a five-second timeout that fails rather than capturing unfinished feedback. Mouse/touch presses remain held while their finite animations settle; release feedback settles before subsequent input. Screenshot-only ButtonSheet configuration disables tickers for loading examples, fixing their perpetual rotation at its initial phase. Widgetbook defaults to live animation; production widgets are unchanged. Both SVG assets are preloaded before settling.

Regenerated and inspected settled pressed captures in both themes and representative loading-sheet crops. Touch captures now show fully expanded ink rather than the earlier partial circles. Strict analysis, screenshot generation, subsequent comparison and whitespace checks passed. The same two grouped tests and 42 captures remain; this is settled-state coverage, not a test of intermediate motion or device rendering. Catalog instructions now describe native settling and the perpetual-animation exception, superseding earlier fixed-duration capture notes.

## Spinner-only screenshot animation control — 2026-11-13

Replaced the sheet's whole-loading-button TickerMode with LoadingIndicatorAnimationScope in the screenshot harness. LoadingIndicator alone consumes this optional presentation scope: disabling it resets and stops its native rotation controller at the initial frame. All button transitions remain enabled and participate in pumpAndSettle. The scope defaults to enabled when absent; application and Widgetbook install no override and retain their existing behavior, including reduced motion. Removed the temporary ButtonSheet animateLoading option.

Formatting, strict analysis, all 13 tests and whitespace checks passed. Existing screenshot baselines matched without regeneration. No new test scenarios or application button options were introduced.

## Compile-time test animation flag — 2026-11-13

Replaced LoadingIndicatorAnimationScope with the global compile-time isTesting constant in lib/environment.dart, supplied by TESTING in the non-secret config.test.json. The existing FLUTTER_TEST variable is process-level rather than a portable compile-time declaration, so it is not used by application code. LoadingIndicator is currently the only consumer: test builds reset/stop rotation, while normal builds retain animation and reduced-motion behavior. Button transitions remain enabled. Other animations require explicit checks when needed; no automatic interception is claimed.

The visual harness now fails early if test mode is absent. Test commands and the ignored-config exception were updated; application/Widgetbook launch commands remain unchanged. Strict analysis, formatting, all 13 tests with --dart-define-from-file=config.test.json and whitespace checks passed. Existing screenshot baselines matched without regeneration.

The animation flag was subsequently renamed to disableInfiniteAnimations / DISABLE_INFINITE_ANIMATIONS to describe its specific effect rather than general test mode. Configuration, consumer, visual-harness guard and catalog documentation use the new name. It remains opt-in per animation; current behavior is unchanged.

## Tertiary touch feedback isolation — 2026-11-13

Tertiary TextButton now follows the existing primary/secondary overlay-fallback approach: a private native-button subclass clears default/theme overlay fallbacks, and a scoped theme supplies bgPrimaryHover as the splash color with transparent hover/focus overlays. This leaves Flutter's pressed highlight transparent instead of applying the ripple color across the whole button. Mouse splash suppression, hover fill, focus outline and native ripple timing are preserved. Link variants still explicitly suppress overlays and splashes.

Strict analysis passed. Initial golden comparison exposed only tertiary touch-pressed edge differences (59 light pixels, 72 dark pixels) from removing the second antialiased highlight layer; inspected both resulting captures and the difference image before updating baselines. Generation and the subsequent full 13-test suite passed. Settled screenshots do not independently verify intermediate motion on a device.

## AppIconButton catalog and screenshots — 2026-11-13

Added AppIconButton light/dark sheets and a playground with every public presentation/interaction input: icon, accessible label, supported hierarchy, size, loading and callback enablement. Defaults follow the constructor (secondary/medium) with the Figma placeholder icon. Reused the catalog-only Focus preview, theme hosting, icon options and sheet composition; the shared renderer instantiates AppIconButton for its family rather than reconstructing it. No production code changed.

The existing grouped runner now covers both families with shared native input/settling logic. Icon sheets contain 45 cells each (three hierarchies, five sizes, default/disabled/loading); medium default cells supply hover, focus, mouse-pressed and touch-pressed captures. Added 26 images, bringing the total to 68 across four grouped tests. Inspected light/dark sheets and representative focus/touch crops. Strict analysis, baseline generation, subsequent full suite (15 tests), Widgetbook web build and whitespace checks passed. Web build retained the tooling's optional Cupertino font warning. No live browser/device or fresh Figma acceptance is claimed; other component families remain pending.

## Unified AppButton interface — 2026-11-13

Removed the redundant AppIconButton wrapper and its separate playground. Icon-only sheets now instantiate AppButton(iconOnly: true) directly, retaining explicit hierarchy/size values and the same labels and icons. Widgetbook groups all four light/dark text/icon-only sheets under AppButton and uses its existing complete playground for both modes. Existing icon-only golden filenames are retained; current docs describe one public button widget.

Formatting, strict analysis, all 15 tests and whitespace checks passed. All 68 screenshots matched without baseline updates. Application appearance and interaction behavior are unchanged.

## Screenshot directory organization — 2026-11-13

Moved all 68 button goldens under test/visual/goldens/macos/ui/widgets/base/app_button/{light,dark}, matching the production widget path while retaining platform-specific baselines. Filenames distinguish text/icon_only sheets and interaction captures without repeating the theme. Updated runner paths and catalog instructions. File hashes were verified unchanged during the move; screenshots were not regenerated. All four grouped visual tests and whitespace checks passed.

## EmptyState catalog and screenshots — 2026-11-13

Added EmptyState grouped light/dark sheets, each covering three sizes with no/one/two actions and a narrow wrapping composition (12 examples). The shared sheet renders production EmptyState and AppButton widgets; no application recipes changed. The playground exposes title, message, icon, size and sample content for the actions slot, with editable action labels/enablement, a host width control, theme selection and the existing native focus preview. Placeholder is the default icon. The catalog entry point is now named ComponentCatalog; focus guidance was generalized for previews with multiple controls.

Added two settled screenshot tests at goldens/macos/ui/widgets/application/empty_state/{light,dark}/variants.png. Inspected both complete sheets for text/action wrapping and clipping. Button interaction captures are reused rather than duplicated in this suite. Formatting, strict analysis, baseline generation, subsequent full 17-test suite, Widgetbook web compilation and whitespace checks passed. Total coverage is six grouped visual tests and 70 PNGs. The build retains the existing optional Cupertino font warning. No fresh Figma or live browser/device acceptance is claimed; app-owned recovery flows and standalone FeaturedIcon catalog coverage remain separate work.

## FeaturedIcon catalog and screenshots — 2026-11-13

Added FeaturedIcon grouped light/dark theme sheets with all 44 valid size/style/color combinations per sheet. The Playground exposes icon, size, color and style with constructor defaults and a separate theme knob; modern/non-gray combinations display guidance without silently coercing values. Sheets use the placeholder icon and the production widget. No production code or design recipes changed.

Added two settled, asset-preloaded screenshot tests at goldens/macos/ui/widgets/assets/featured_icon/{light,dark}/variants.png. Inspected both sheets and a magnified icon crop. No interaction tests were added for this decorative component. Formatting, strict analysis, generation, subsequent full suite (19 tests), Widgetbook web build and whitespace checks passed. Catalog coverage now totals eight grouped visual tests and 72 PNGs. The existing optional Cupertino font warning remains. No fresh Figma or live browser/device acceptance is claimed; other UI families remain pending.

## Dark FeaturedIcon effect correction — 2026-11-13

Inspected current Cat tinder Featured icon component set 94:6881 through the local agent plugin at /Users/askar/projects/figma/agent-plugin after the hosted connector reported its plan limit. Verified all 20 Type=Dark variants have the same gradient stroke and effect array as primary Button 14:10: inside 2px white-to-transparent highlight, shadow-xs, bottom inset and inner outline. Exported 94:6787 as a visual reference. Radius/radius-sm resolves to 6px; dark sizes use 6/8/10/12px.

FeaturedIcon now applies those shared effects to dark variants with native decorations and ShaderMask. Added the missing 6px sm radius and named the existing 4px value xs; other existing consumers explicitly retain their prior 4px geometry. Light and modern variants, button behavior and Figma files are unchanged. Inspected updated dark rows in both theme sheets. Formatting, strict analysis, FeaturedIcon baseline regeneration, subsequent full suite (19 tests) and whitespace checks passed. Button and EmptyState baselines matched without regeneration. No live-device rendering claim is made.

## Light-style FeaturedIcon dark foregrounds — 2026-11-13

Switched the light-style foreground mapping to the existing featuredIconLightFg tokens as authorized. Dark theme now uses their 200-level colors; modern/dark styles and backgrounds are unchanged. Verified the light sheet against its existing baseline before updating only the dark sheet, then inspected the updated dark capture. Strict analysis, formatting, all 19 tests and whitespace checks passed. The light baseline was not regenerated.

## AppTooltip catalog and screenshots — 2026-11-13

Added grouped light/dark AppTooltip sheets covering seven arrow placements with and without supporting text (14 examples per theme). Each production tooltip uses a native local overlay; Forui continues to own placement, collisions and arrows. The playground exposes message, nullable supportingText, arrow and sample widgets for the arbitrary child slot, plus theme and target-position host controls for manual edge checks. Application code, styling, hover delay and long-press behavior are unchanged.

Two grouped screenshot tests reveal all examples using independent mouse devices, wait for observable appearance through the hover timer, and settle entrance transitions before capture. Exit cleanup also waits for removal and settles. Inspected the sheets and corner-arrow crops; screenshots reside under goldens/macos/ui/widgets/base/app_tooltip/{light,dark}/variants.png. Strict analysis, the full 21-test suite, Widgetbook web build and whitespace checks passed. Coverage now totals ten grouped visual tests and 74 PNGs. The build retains its existing optional Cupertino font warning. These snapshots do not claim live-device, touch or viewport-edge acceptance; remaining component families and unfinished product features remain pending.

## Constrained catalog guides — 2026-11-13

Added a shared catalog-only dashed secondary border around EmptyState width constraints and AppTooltip local viewports, including their playgrounds. The foreground painter does not intercept pointers or alter layout, padding or clipping. Production widgets remain unchanged. Updated and inspected the affected light/dark screenshot baselines; strict analysis and the four affected screenshot tests passed. Other component recipes and unfinished features are unchanged.

## Tooltip preview controls and viewport coordinates — 2026-11-13

Source inspection identified two independent issues. Widgetbook 3.25.0 nullable-string defaultToNull tests the entire query group when returning a value but the specific field when rendering its checkbox; changing another knob could enable supporting content without checking its box. The playground now uses an explicit boolean and text field, passing null when disabled and preserving entered text.

Forui 0.27.7 uses global target offsets with MediaQuery size for collision decisions. Widgetbook supplies a smaller preview size without changing global coordinates; a nested Overlay alone did not establish the previously claimed collision viewport. AppTooltip now caps content width to its nearest visible overlay and converts coordinates before delegating to FPortalOverflow.flip. Safe-area and keyboard offsets are accounted for. Forui still owns flip/slide, arrow adjustment, hover/long-press recognition and transition lifecycle; design styling is unchanged.

A temporary diagnostic exercised all seven arrows in offset 600px/240px previews at center and opposite corners, toggling supporting content, checking containment and centered placement. It passed and was removed rather than adding another permanent per-issue UI matrix. Both existing tooltip screenshots matched without regeneration; strict analysis and all 21 retained tests passed. Live browser/device interaction was not verified in this pass.

## Catalog-only tooltip positioning — 2026-11-13

Moved the offset-overlay workaround and content-width cap out of AppTooltip into widgetbook/catalog_tooltip.dart. CatalogTooltip subclasses AppTooltip using protected placement/content hooks; it inherits the production styling, content, semantics, gestures and transitions without duplicating the recipe. Sheets and the playground use this subclass. Application AppTooltip again delegates directly to FPortalOverflow.flip and applies only its original design constraints and spacing. The explicit supporting-text boolean/text controls remain unchanged.

Strict analysis and all 21 retained tests passed; existing tooltip screenshots matched without regeneration. A temporary diagnostic verified all arrow variants in offset 600px/240px previews at center and corners, including supporting-content toggles, containment and centered placement. It passed and was removed rather than retained as another per-issue suite. Catalog screenshots exercise the shared recipe with catalog positioning; they do not verify native application viewport placement. No live-device acceptance is claimed.

## Catalog tooltip corner collision — 2026-11-13

The supporting-text/right-arrow/top-left case exposed Forui 0.27.7 recomputing its second-axis flip from the original anchors, undoing the first flip. Updated only the catalog adapter to compose the package's primary-axis flip and cross-axis slide separately. When neither horizontal side has enough room and the tooltip overlaps its target, it tries the perpendicular axis using the same package policies. Forui still computes positions and arrows; application tooltips remain native and unchanged.

A temporary diagnostic checked body non-overlap and viewport containment for all seven arrow options at four corners and center in offset 600px/240px previews with supporting text. All checks passed; the diagnostic was removed to avoid expanding the permanent per-issue suite. Existing grouped screenshots matched without regeneration. This verifies the tested preview sizes, not arbitrary content in viewports too small to fit both target and tooltip. No live-browser/device acceptance is claimed.

## Shared tooltip corner correction — 2026-11-13

Moved the corner-collision policy into AppTooltip so application tooltips receive the same primary-axis flip/cross-axis slide correction and perpendicular fallback as the catalog. The policy composes Forui operations; it does not implement a replacement placement solver or arrow renderer. CatalogTooltip now wraps the inherited policy only to convert its offset viewport coordinates. Overlay measurement, safe-area coordinate conversion and the catalog width cap remain under widgetbook. Supporting-text controls, styling, hover delay and long-press behavior are unchanged.

Strict analysis and all 21 retained tests passed; screenshot baselines matched without regeneration. A temporary diagnostic rendered the actual application AppTooltip, without the catalog subclass, and checked containment and target non-overlap for every arrow at all four corners and center on 600px and 240px viewports with supporting text. It passed and was removed to avoid a permanent per-issue UI matrix. No live-device verification or guarantee for viewports too small to fit the content is claimed.

## Tooltip fallback non-overlap — 2026-11-13

Confirmed the perpendicular fallback could still overlap when neither axis had sufficient room. Both candidates now validate against the target plus the design gap, preserving arrow clearance as well as body separation. If both fail, Forui's allow policy computes an unclamped placement on the roomier perpendicular side. This explicitly prioritizes an uncovered target over viewport containment in undersized viewports; some tooltip content may be outside the visible area. Catalog coordinate handling remains separate and unchanged. No custom arrow or replacement position solver was introduced.

A temporary diagnostic exercised the actual FTooltip policy configured by AppTooltip over all seven arrows, three viewport sizes, four tooltip sizes (including oversized content), and five target positions: 420 placements. All retained the required target clearance. Removed the diagnostic after verification rather than retaining another per-issue matrix. This checks placement geometry, not live-device rendering or shadow pixels.


## Native tooltip overlay adoption — 2026-11-13

Replaced FTooltip's internal portal with Flutter's `OverlayPortal.overlayChildLayoutBuilder`, following the isolated synchronous prototype. AppTooltip remains an atomic UI component with an unchanged constructor. Its private layout measures and constrains content before paint, preserves fitting design anchors, and delegates final slide placement and target-aligned arrows to unmodified Forui 0.27.7 public APIs. Overflowing content scrolls natively. Impossible space/offscreen targets suppress the body rather than covering the target. Local timer/animation ownership replaces Forui's tooltip orchestration, preserving the 500ms hover, held long press, 1500ms release, 100ms hover-exit grace and reduced-motion behavior; Escape dismisses focused tooltips.

Removed the catalog coordinate subclass; both grouped sheets and the playground render production AppTooltip in native local overlays. The seven placements, Figma styling and public widget options remain unchanged. No dependency, design-file or pending-feature changes. Private presentation, sizing and lifecycle helpers remain in the widget file; no application state or cross-layer dependencies were added (manual G1–G3/G7 review).

Verification: the existing light/dark tooltip screenshots pass without baseline changes. The isolated harness imports the actual application widget and passes nine checks covering hover/long-press timing, keyboard Escape, fade reversal/timer disposal, exact unobstructed placement/gaps, scrollable content, target movement, root/nested overlay resizing and 252 sampled frames without body overflow or target overlap. Scratch checks are not added to the permanent per-issue UI suite. Further validation and environment limits are recorded below.

Final checks: formatting completed; `flutter analyze --fatal-infos --fatal-warnings` reports no issues; `flutter test --dart-define-from-file=config.test.json` passes all 21 existing tests, including unchanged light/dark tooltip baselines; `git diff --check` passes. Widgetbook compiled and opened in the live in-app browser without console errors, but its browser controls did not expose the tooltip interaction, so no live tooltip/touch-device acceptance is claimed. RTL, enlarged text and keyboard/safe-area combinations remain unverified. Pending product features remain pending.

### Tooltip padding cleanup — 2026-11-13

AppTooltip now resolves its content padding once and shares it between the rendered Padding and the private layout's suppression check. The available width/height must exceed the actual horizontal/vertical padding totals; message-only content therefore uses its 16px vertical total rather than the former fixed 24px threshold, while supporting text retains its 24px total under the default variables. Replaced the local-only FPortalSpacing implementation with a private spacing function, preserving the Forui calculation and corner inset. Styling, placement, arrows and interaction handlers are unchanged. Formatting, fatal-info/warning analysis, both existing light/dark tooltip screenshot tests (without baseline updates), and `git diff --check` pass. No new test scenarios or pending-feature changes.

### Tooltip scheduling/body cleanup — 2026-11-13

Centralized cancel-and-replace delayed actions in `_schedule` for hover entry, hover exit and long-press release. Extracted the existing semantics/decoration/padding/text/scrolling subtree into `_buildTooltipBody`, retaining the helpers in AppTooltip's file. Overlay, fade, hit-testing, focus and gesture wrappers keep their existing order; sizing, placement, arrows, styles and timing values are unchanged. Immediate show/hide and disposal still cancel pending actions. No RawTooltip adoption or new public configuration.

Validation: formatting and fatal-info/warning analysis pass; existing light/dark tooltip screenshots pass without baseline updates; the existing isolated harness importing production AppTooltip passes all nine geometry/interaction checks, including 252 sampled movement/resize frames, hover/held-touch timing, keyboard dismissal, fade reversal and timer disposal. `git diff --check` passes. No permanent test scenarios added; pending features remain pending.


### Tooltip viewport padding — 2026-11-13

Added the public `viewportPadding: EdgeInsets` option with a zero default. It reserves space between the tooltip body boundary and its nearest overlay's safe viewport, independently of content padding and target gap. Resolved insets feed the existing synchronous sizing/Forui slide path; side capacities are bounded to the inset viewport even when the target sits within a reserved margin. Target visibility still uses the actual safe viewport so the extra margin does not suppress otherwise visible targets. No arrow painter or interaction changes. Widgetbook exposes all four edges through nonnegative sliders; existing sheets retain zero padding.

Validation: fatal-info/warning analysis passes; both existing light/dark tooltip screenshot tests pass without baseline changes; the scratch production-widget harness passes ten checks, including asymmetric padding across all seven arrow variants with a target in the reserved margin, plus the retained 252-frame geometry and interaction checks. Formatting and `git diff --check` pass. These checks cover body containment, not decorative shadow pixels. No permanent per-issue tests or unfinished product features were added.


### Application tooltip boundaries — 2026-11-13

Applied viewport padding to the actual discovery detail-link and root-tab tooltips. ApplicationLayout.containerPadding resolves the shared frame gutter from UI spacing variables (space(4) mobile / space(8) desktop, 16px/32px by default). ApplicationFrame now uses that same resolver. HorizontalTabs accepts a presentation-only tooltipViewportPadding forwarding option, defaulting to zero; no app layout dependency enters shared UI.

ApplicationContentOverlay, in the app layout file, wraps the existing scrollable below ApplicationHeader and limits its native overlay to the application maximum width. The header is excluded by actual layout, including enlarged-text height changes; no hardcoded header offset or position observer was added. Scrollable PageStorage keys, the retained content key, single tab strip and view crossfade remain in place. Native Overlay.wrap owns overlay updates/clipping. Standalone and catalog defaults are unchanged.

Validation: formatting and fatal-info/warning analysis pass; all 21 existing tests pass without screenshot changes. A scratch check using the actual header, layout, tab and discovery-footer widgets verifies both tooltip consumers at widths 390, 1024 and 1600, with text scales 1 and 2: expected variable-based padding, frame containment and placement below the actual header. `git diff --check` passes. No new permanent per-issue UI tests; live device/navigation acceptance was not performed for this layout change. Pending features remain pending.


### Restore full-width content; constrain only tooltips — 2026-11-13

The preceding content overlay implementation constrained the entire scroll viewport to 1280px. A before/after review reproduced early card clipping and lost drag/wheel scrolling in desktop outer gutters. Fixed ApplicationContentOverlay to remain full-width below the header. Its LayoutBuilder computes the centered frame's outer margin from actual available width and exposes tooltip-only insets through a private app-owned inherited layout configuration. Both current tooltip call sites read ApplicationLayout.tooltipViewportPadding; horizontal insets are outer margin plus the variable-based container gutter, while vertical insets retain the gutter. Shared UI receives explicit padding and has no dependency on app layout. No custom header measurement, gesture, scroll or transition logic was added.

The original scrollable key, retained content key, shared tab strip and crossfade remain. The app shell builds the scroll subtree under the inherited layout configuration so resizing updates both tooltip consumers. The native overlay continues excluding the header; its clipping boundary is now the full content viewport rather than the narrower frame.

Validation: formatting, fatal-info/warning analysis and all 21 existing tests pass; `git diff --check` passes. The isolated before/after harness exercises production card/view widgets at 390px and 1600px: swipe voting, vertical drag over the card, outer-gutter drag and wheel scrolling, retained card/tab-strip instances, restored scroll offset and intermediate crossfade values match the pre-overlay layout. Wide-screen drag PNGs are byte-identical to that reference. A separate scratch check verifies both tooltip consumers at 390/1024/1600px and text scales 1/2 against the intended frame gutters and actual header. No permanent per-issue suites were added. These are Flutter harness checks, not live browser/Android acceptance; unfinished features remain pending.


### Tooltip-owned maximum viewport width — 2026-11-13

Added AppTooltip.viewportMaxWidth (nonnegative double, unlimited by default). The existing synchronous layout computes the centered horizontal margin from actual safe overlay width and then applies viewportPadding. Both application tooltip consumers explicitly supply ApplicationLayout.maxWidth and the shared variable-based container padding; HorizontalTabs forwards the new option. Widgetbook exposes unlimited/finite width without changing default sheets.

Removed the private inherited boundary configuration, its lookup helper and LayoutBuilder, plus the shell's extra Builder. ApplicationContentOverlay is now only a full-width Overlay.wrap below the header. No page-size, swipe, scroll, key, tab-history or crossfade policy changes.

Validation: formatting, fatal-info/warning analysis and all 21 existing tests pass without golden updates. Eleven scratch integration checks pass for tooltip geometry/interactions and actual app consumers at mobile/desktop/wide widths and normal/enlarged text. The separate before/after app harness confirms swipe voting, vertical card scrolling, outer-gutter drag/wheel scrolling, retained card/tab-strip instances, restored scroll offsets and matching intermediate crossfade values at 390px and 1600px. Wide-screen drag screenshots remain byte-identical to the pre-overlay reference. `git diff --check` passes. No permanent per-issue tests added; live-device acceptance and unfinished product features remain pending.


### Inline the native content overlay — 2026-11-14

Replaced the shell's ApplicationContentOverlay invocation directly with Overlay.wrap and removed the redundant wrapper class from application_layout.dart. The native overlay stays inside Expanded below ApplicationHeader, around the same full-width scrollable. PageStorage and retained-content keys, tab-strip/view structure, tooltip bounds and interaction logic are unchanged.

Validation: formatting, fatal-info/warning analysis and all 21 existing tests pass. Existing scratch before/after checks pass for mobile/wide-screen swipe voting, vertical card scrolling, outer-gutter drag/wheel scrolling, retained card/tab-strip state, intermediate crossfades and restored scroll offsets; wide-screen drag captures are byte-identical to the reference. Header exclusion and responsive tooltip bounds pass at 390/1024/1600px with normal/enlarged text. `git diff --check` passes. No new permanent tests or pending-feature changes; live-device acceptance is not claimed.


### TabButton and HorizontalTabs catalog — 2026-11-14

Added production-component Widgetbook light/dark grouped sheets and all-option playgrounds. TabButton covers 120 examples per theme across six styles, both sizes, selection, slots and disabled callbacks. HorizontalTabs covers 40 desktop examples across five styles, both sizes and four compositions, plus four mobile select examples without repeating ignored desktop styles. Playgrounds expose every component presentation/callback option and every TabItem field, with editable sample slots, native focus preview, controlled live selection and duplicate-value guidance. Host width, local overlay and dashed boundaries belong only to the catalog. Whole sheet cells clip overflowing content to protect neighboring examples; the production viewport itself is not changed.

Four new grouped Alchemist tests capture settled light/dark sheets under ui/widgets/application/tab_button and ui/widgets/application/horizontal_tabs. The catalog totals 14 grouped visual tests and 78 PNGs. Existing baselines were not regenerated. No production widget, styling, transition, interaction or application code changes were made for this addition.

Validation: fatal-info/warning analysis and all 25 tests pass, including comparison against the four new baselines. All four new images were inspected. An isolated Widgetbook harness verified callback/selection/style/size/slot knobs, desktop and native mobile selection, selected-value changes, item removal, duplicate-value guidance and the focus-preview action. This is not live browser/device or exhaustive interaction acceptance. Formatting and git diff --check pass. Remaining component families and unfinished product features stay pending.

The sheets expose existing issues for later review: TabButton's leading IconTheme sets size without preserving inherited color, leaving sample AppIcon strokes black in dark mode; HorizontalTabs uses Clip.none on its horizontal scroll view and can paint past its constrained viewport. Neither was masked by a production fix in this catalog task.

### Tab foreground inheritance and overflow fixes — 2026-11-14

Resolved the two findings from the tab catalog: the leading slot now uses IconTheme.merge for its size, retaining the existing animated foreground; non-full-width HorizontalTabs rows restore SingleChildScrollView's native hard-edge clipping rather than Clip.none. No color tokens, animation curves/durations, ripple factories, gesture handlers, focus policies, keys or selection callbacks changed. Overflowing rows are clipped to the native viewport, including decorations at its edges; nonoverflowing rows retain native conditional clipping. Full-width rows and mobile selects are unchanged.

Updated only the four affected tab sheet baselines and reconciled the catalog/UI documentation. Fatal-info/warning analysis and all 25 tests pass. Isolated checks confirm matching inherited icon/text colors during hover and selection transitions, native horizontal scrolling and selection after scrolling; the existing playground interaction smoke check also passes. Inspected updated light TabButton and dark HorizontalTabs sheets. Formatting and whitespace checks pass. No new permanent per-issue tests; live-device acceptance was not performed.

### Preserve tab decorations at clipped scroll boundaries — 2026-11-14

The preceding native viewport clip also trimmed focus outlines and shadows when content overflowed. Replaced it with a private paint-only ClipRect inside the native SingleChildScrollView. Its CustomClipper listens to the existing ScrollPosition: vertical clearance preserves decorations; horizontal clearance is allowed only at the content ends, while edges cutting through scrolled content remain clipped. Clearance uses the existing shadow blur/spread/offset and a 4px focus-outline minimum. RTL uses the native axis direction. No padding, layout size, extra scroll extent, controller, gesture handler, selection policy or animation changes. Fully expanded rows and mobile selects are unchanged.

Validation: analysis and all 25 project tests pass; affected grouped tab screenshots were refreshed. Isolated focused captures show complete outlines at the first and last tabs, with adjacent overflow clipped, in LTR and RTL. Scroll-boundary checks cover start/middle/end positions and unchanged layout size. Existing isolated hover/selection color, scroll/selection and Widgetbook checks pass. Formatting and whitespace checks pass. No permanent per-issue test suite added; live-device acceptance remains unclaimed.

### Simplify tab clipping maintenance — 2026-11-14

Extracted decoration clearance into the private _tabDecorationOutset function in horizontal_tabs.dart, preserving the exact style selection and shadow/focus calculation. The clipper now returns true from shouldReclip: a replacement clipper recalculates the boundary even when only viewport dimensions change, avoiding the stale clip observed until the next scroll. Existing scroll-listener repainting, RTL conversion, endpoint clearance, semantics clip, layout and interaction ownership are unchanged.

Validation: fatal-info/warning analysis and all 25 project tests pass without screenshot updates. All five existing isolated checks pass, including the previously failing viewport-resize comparison, LTR/RTL start/middle/end clipping, focused decoration captures, hover/selection color inheritance, scrolling and playground controls. Formatting and git diff --check pass. No new permanent test scenarios or live-device acceptance claims.

### Align tab hover and focus with Figma — 2026-11-14

Read all 72 _Tab button base variants (29:998), both sizes, all 40 Horizontal tabs group variants (29:1007), and the mobile select base through the local Agent plugin. Desktop groups have no fill/stroke/text overrides of the audited base; state recipes are identical across sizes. Figma defines Default/Hover/Focus, not pressed states. Following the user's explicit reconciliation, removed the unselected gray hover fill and the vertical-line focus outline. Gray text/icon hover transitions and its separate focus background remain; brand/gray/white/minimal focus outlines are preserved.

Reduced the gray background tween from hover/focus Offset to a focus-only double. Native ripple factories/colors, the theme-color adapter, 225ms selected-background reveal, 200ms deselection/focus/text transitions, callbacks and layout/clipping are unchanged. Updated the UI guide and maintenance instructions to supersede the earlier accepted differences. Figma was not modified.

Validation: analysis and all 25 project tests pass without screenshot updates. Seven isolated checks pass, including transparent gray hover/touch base fill, delayed selected fill and deselection fade, absence of the line outline with button-style outlines retained, existing viewport resizing/LTR/RTL clipping and catalog selection checks. No permanent per-issue tests added; live-device acceptance was not performed.


### Tab ripple device policy — 2026-11-14

TabButton now observes only pointer down/up/cancel to distinguish mouse presses, matching AppButton's device policy without adding hover tracking or a gesture recognizer. The splash factory chooses native NoSplash for mouse and retains native InkRipple for other input, including the existing gray theme-color adapter. Mouse pressed overlays are transparent. Underline tabs continue to have no ripple for any input. Keyboard activation, touch ripple colors/lifecycle, hover/focus styles, gray selection timing, layout and clipping are unchanged. Device selection is per event, so desktop touchscreens retain touch feedback.

Validation: fatal-info/warning analysis and all 25 project tests pass without baseline changes. The isolated rendered press check passes across all six variants: mouse-down captures match settled hover, touch feedback remains visible except for underline, and each activation calls its callback once. The seven existing isolated checks also pass, including selection timing and viewport behavior. No new permanent regression suite; live-device acceptance was not performed.

### Prevent mouse-release tab background flash — 2026-11-14

The pointer-up reset exposed the touch overlay color while Flutter's pressed InkHighlight was still fading. TabButton now retains the overlay suppression decision through that fade. Pointer-down selects the next device policy; splash creation also resets it for keyboard activation. The active pointer kind still clears on up/cancel. The factory supplies the existing explicit ripple color when creating normal touch/keyboard ink, so a preceding mouse activation cannot leave a transparent initial splash. No timer, gesture recognizer, custom animation or change to selection timing was added.

Validation: analysis and all 25 project tests pass without screenshot updates. Eight isolated checks pass, including rendered mouse-down and all 16 release frames (256ms) across all six tab variants followed by touch activation, plus the existing selection timing, focus and clipping checks. No permanent per-issue tests added; live-device acceptance was not performed.

### Simplify tab feedback bookkeeping — 2026-11-14

Removed the duplicate overlay-suppression assignment from pointer-down; the splash factory remains responsible for setting the activation's suppression policy before native highlight creation. The overlay resolver now reuses _rippleColor instead of repeating its style-dependent calculation. Active-pointer cleanup and the separate suppression flag that survives release remain intact. Mouse/touch feedback, transitions, focus, selection timing and layout are unchanged.

Validation: fatal-info/warning analysis and all 25 project tests pass without baseline updates. Three isolated production-widget checks pass, covering all six variants' mouse press/release frames and subsequent touch activation, gray selection/deselection timing, and focus-outline policies. Formatting and git diff --check pass. No new permanent test scenarios or live-device acceptance claims.


### Prevent the border-tab selection dark flash — 2026-11-14

Frame inspection isolated a second cause of dark feedback: white/border and minimal tabs painted their selected BoxShadow immediately while the selected fill still had zero/partial opacity. The shadow's interior showed through until the fill covered it. These variants now reveal the selected shadow when the fill reaches its target opacity. No new timer/controller or change to fill/text transition duration, gray selection timing, pointer policy, ripple lifecycle, layout, clipping or settled shadow recipe.

Validation: fatal-info/warning analysis and all 25 tests pass without baseline updates. Isolated selection captures at 0/16/100/250ms confirm the border fill no longer starts dark; final shadow captures were inspected with real shadows enabled. Existing mouse-release/touch feedback and gray selection/focus checks pass. Formatting and whitespace checks pass; no permanent per-issue suite or live-device acceptance claim.


### Fade selected tab surfaces as a composited layer — 2026-11-14

White/border and minimal tabs now fade an opaque fill, border and shadow together with native AnimatedOpacity (200ms linear, immediate under reduced motion). The private _TabSelectionSurface stays in tab_button.dart, below the native TextButton Material. It contributes no layout size or hit target. Text/icon transitions, focus ink/outline and native ripples remain outside the opacity layer; native button focus/state handling is retained without adding a state controller or listener. Removed the shadow-at-transition-end condition. Gray selection timing and all other tab variants are unchanged.

The new composition also exposes the full existing shadow recipe: the old Ink-painted shadows were clipped to the Material ink bounds even with clipBehavior none. Reviewed and updated only the four tab sheet baselines for the now-visible outer shadows/border edges. The paint-only scroll clip still reserves decoration clearance and clips overflow.

Validation: fatal-info/warning analysis and all 25 project tests pass against reviewed baselines. Seven isolated checks pass: selection frames with real shadows at 0/16/100/250ms, mouse/release and touch feedback for selected and unselected variants, gray selection timing/focus policy, LTR/RTL scroll edges and viewport resizing. Old/new settled TextButton and Ink dimensions are identical in the comparison harness. No new permanent per-issue tests; live-device acceptance remains unclaimed.


### Remove gray mouse-selection delay — 2026-11-14

Gray mouse selection no longer waits for a ripple that mouse input suppresses. The background uses a 200ms linear fade starting immediately; touch/keyboard retain the 225ms threshold reveal and deselection remains a 200ms fade. The private background receives waitForRipple from the existing activation policy, without new pointer tracking or timers. Ripples, hover/focus, text, geometry and final colors are unchanged.

Validation: analysis and all 25 project tests pass without baseline changes. Four isolated checks pass, including visible mouse-fill progress at 16ms and 100ms, existing touch reveal/deselection timing, focus policy and all-variant mouse-release/touch feedback. Formatting and whitespace checks pass; no permanent per-issue tests added.

### Simplify tab background interpolation — 2026-11-14

Removed the redundant zero-focus branch around Color.lerp. _TabBackground now reads reduced motion once and shares its resolved 200ms/zero duration across focus opacity, focus blending, ordinary fill/indicator transitions and gray mouse/deselection animation. Gray touch/keyboard selection retains the separate 225ms threshold duration when animations are enabled. No animation-layer, curve, input, layout or selection changes.

Validation: analysis and all 25 project tests pass without baseline changes. Five existing isolated checks pass for immediate gray mouse selection, touch reveal/deselection timing, focus policy and selected/unselected mouse-release/touch feedback. Formatting and whitespace checks pass; no permanent per-issue tests added.


### Match brand-tab held-touch color to its surface — 2026-11-14

Brand tabs now resolve their touch/keyboard ripple and pressed overlay to bgBrandPrimaryAlt, the same token as the selected fill. This removes the gray held-touch surface followed by a brand-colored surface on release. Gray and other variants retain their existing colors. Native ripple lifecycle, mouse suppression, transitions and selection timing are unchanged.

Validation: analysis and all 25 project tests pass without baseline changes. Five isolated checks pass, including rendered held-touch versus settled selected background equality for brand tabs in light/dark themes, native activation, all-variant mouse/touch feedback, and existing gray timing/focus checks. Formatting and whitespace checks pass; no permanent per-issue suite added.


### Audit remaining tab touch colors — 2026-11-14

Audited all six variants. White/border and minimal touch/keyboard feedback now uses bgPrimaryAlt instead of the generic translucent gray tint, matching their selected surfaces. Brand retains bgBrandPrimaryAlt; gray retains bgPrimaryHover. Vertical-line tabs have no selected surface and retain their existing transient foreground ripple; underline remains ripple-free. The explicit color switch does not alter mouse suppression, transitions, ripple lifecycle or selection timing.

Validation: analysis and all 25 project tests pass without baseline updates. Five isolated checks pass: rendered held-touch versus settled selected surface colors for all four filled variants in light/dark and selected/unselected states; all-variant mouse-release/touch feedback; gray mouse/touch selection timing; focus policy. No permanent per-issue tests added. Formatting and whitespace checks pass; live-device acceptance remains unclaimed.

### Catalog constraint-guide scope

Restricted dashed preview boundaries to EmptyState and AppTooltip. Removed the guide from HorizontalTabs sheets and playground while retaining the same sizing, overlay and production widgets. Updated the catalog guide and reviewed the light/dark HorizontalTabs baselines. Strict Flutter analysis and all four tab screenshot tests passed; application UI and interactions are unchanged.

### Scope theme-control overrides to Settings

Extracted a page-owned ThemeSelector with only the Light/Dark/System gray-button recipe. It retains live-theme fill interpolation, theme-following native ripple color, mouse/touch distinction, focus decoration and the accepted 225ms touch/keyboard selection reveal. Shared TabButton no longer owns the theme-color InkRipple adapter or the gray-specific background interpolation/timing branch: gray uses the standard 200ms ColorTween and native ripple path. No domain options or presentation hooks were added to the shared component. Settings owns selection callbacks; Flutter still owns gestures, focus and animation lifecycle.

Validation: strict analysis and all 25 existing tests passed with unchanged screenshot baselines. An isolated comparison against the prior implementation matched rendered Settings controls pixel-for-pixel at rest, during held touch and across sampled theme-change/ink-fade frames. No permanent per-issue tests added. Live Android acceptance was not performed.

### Reuse TabButton for Settings theme controls

ThemeSelector now composes shared gray TabButtons instead of maintaining a second TextButton implementation. TabButton exposes two optional presentation hooks: base-fill animation via resolved presentation inputs and a shared paint callback, and touch/keyboard ripple factory creation via a live color getter. Defaults retain ordinary color interpolation and native InkRipple. Shared geometry, typography, foreground transitions, focus decoration, semantics and mouse ripple/overlay suppression remain owned by TabButton; underline and white/minimal selection-surface policies are unchanged. Settings alone supplies live-theme fill interpolation, delayed touch selection and the theme-following ripple color adapter. No Settings dependency or domain flag enters UI. Playground sample knobs expose both callback options without importing application code.

Validation: strict analysis and all 25 existing tests passed without changing screenshot baselines. Isolated before/after pixel comparisons passed for touch and mouse activation, sampled theme-transition frames, settled selection and focused rendering. No permanent per-issue tests were added. Live device rendering was not revalidated.

### Simplify Settings presentation hooks

Reused the selection timing condition for duration and curve, and replaced the ripple-factory forwarding function with a positional constructor tear-off. Styling, focus, native input handling and animation policies are unchanged. Strict analysis and the two isolated mouse/touch rendering comparisons passed, including focused and theme-transition frames; no new permanent tests or screenshot updates.

### ThemeSelector catalog playground

Added a dedicated Widgetbook playground using the production Settings ThemeSelector and a catalog-local AnimatedTheme with MaterialApp's default transition timing. Local selection, simulated system brightness, reduced motion, preview width and callback sample controls support inspecting theme transitions independently of shared tabs. Native Focus preview is reused; there is no constraint guide, app startup, preference persistence or application code change.

Validation: strict analysis passed. An isolated Widgetbook check verified intermediate theme colors, settled Light/Dark/System resolution, callback/no-op samples, reduced motion, focus entry, Tab traversal and Escape return. No permanent per-issue tests or screenshot baselines were added.

### ThemeSelector grouped screenshots

Added fixed light/dark Widgetbook sheets rendering all three selected appearance values through the production ThemeSelector. Two Alchemist tests reuse the sheets and wait for native animation settlement before capture. Baselines follow the widget-owned path at goldens/macos/app/pages/settings/theme_selector/{light,dark}/variants.png. Reviewed both rendered sheets; strict analysis and both baseline comparisons passed. The interactive playground and application code/behavior are unchanged; transition and interaction inspection remains in the playground rather than duplicated in new scenario tests.

### Minimal-tab neighboring focus ring

Reproduced a focused minimal tab's right-hand ring being covered by the selected tab immediately to its right. Minimal groups now paint the selected child first through a private RenderFlex defaultPaint override; sibling focus decoration stays visible without changing spacing, dimensions, native focus/input ownership or animation recipes. Native flex overflow handling and the existing scroll viewport clip remain in place. Other group styles are unchanged.

Validation: visually inspected the corrected focused-neighbor rendering. Isolated focused-overflow and LTR/RTL scrolling-edge checks passed; all four settled tab screenshot comparisons passed without baseline updates. No permanent per-issue test was added.

### Faster tab color transitions

Changed shared tab linear transitions from 200ms to 100ms: text/icon colors, fills, fixed indicators, focus fades and the composited white/minimal selected surface. Settings inherits the faster focus/mouse-selection/deselection duration through its existing fill hook. Native ripple timing, the Settings 225ms touch/keyboard reveal, application-wide theme animation and reduced-motion behavior are unchanged. Strict analysis and all six tab/ThemeSelector screenshot tests passed without baseline updates.

### Simplify minimal-tab paint adapter

Used the concrete render-object type for creation/update and Flutter's childAfter() for sibling traversal. Selected-first paint order and native layout/input ownership are unchanged. Strict analysis, all four tab screenshot comparisons and two isolated focused-neighbor/scrolling-edge checks passed; visually reviewed the complete neighboring focus ring. No baseline updates or permanent tests added.

### Native tab-row spacing

Replaced explicit SizedBox gaps in HorizontalTabs and ThemeSelector with Row.spacing. The minimal Row/RenderFlex adapter forwards spacing at creation and uses native updates; its selected child now uses the item index directly, without spacer-index multiplication. Paint priority, viewport clipping, focus and input handling, and 100ms transition recipes are unchanged. Strict analysis, all six tab/ThemeSelector screenshot comparisons and two isolated focus/scroll checks passed without baseline changes; visually verified the neighboring focus ring.

### Shared internal pointer and ripple mechanics

Extracted PointerFeedback and DelegatingRippleFactory under ui/widgets/internal. AppButton and TabButton reuse passive pointer tracking and ink-factory argument forwarding while retaining their own suppression/color policies. AppButton keeps hover restoration, loading/link rules, native overlay overrides and cancellation fading; TabButton keeps the activation policy through fading highlights; Settings keeps live-theme ripple behavior. The helper introduces no gesture recognition, notifier, timer or application state. Existing Listener/MouseRegion, Material and semantic nesting are preserved.

Validation: strict analysis and all 27 existing tests passed without screenshot changes. Three isolated checks passed for tab mouse/touch feedback and Settings mouse/touch theme-transition and focused rendering at the current 100ms timing. No permanent per-issue tests added; live-device verification was not performed.

### Shared internal focus and highlight decorations

Extracted FocusRing for AppButton/TabButton and GradientHighlightStroke for AppButton/FeaturedIcon into ui/widgets/internal. The helpers retain the same IgnorePointer, AnimatedOpacity, ShaderMask and rounded-border recipes. Owners retain Positioned.fill, stack/clip configuration and paint order, focus visibility/timing, and all other borders/insets/shadows. No interaction or animation policy moved into the helpers.

Validation: strict analysis and all 27 existing tests passed with unchanged screenshot baselines. Four isolated checks passed for tab mouse/touch feedback, Settings mouse/touch theme/focus rendering and neighboring minimal-tab focus rendering. No new permanent tests added; live-device rendering was not revalidated.

### Spinner lifecycle and header spacing cleanup

LoadingIndicator now starts repetition only when its controller is not already animating, avoiding needless simulation restarts on dependency changes. Screenshot reset remains the first branch; reduced motion still stops rotation, and leaving reduced motion resumes it. PageHeader uses native Row.spacing for the existing text/action gap. Styling and all other behavior are unchanged. Formatting, strict analysis and all 27 existing tests passed with unchanged screenshot baselines.

### Native uniform column spacing

Replaced explicit uniform vertical gaps with Column.spacing in PageHeader text, EmptyState text, LoadingState's icon/text and title/message columns, and AppTooltip supporting-text content. EmptyState's differing icon/content/action gaps remain explicit. Existing spacing tokens, constraints and child ordering are unchanged. Formatting, strict analysis and all 27 existing tests passed with unchanged screenshot baselines; no interaction code changed.

### Loading component catalog and screenshots

Added grouped light/dark sheets and all-option playgrounds for production LoadingIndicator and LoadingState. Indicator sheets cover four representative sizes and three color configurations; state sheets cover standard/long content and narrow wrapping. Playground controls expose numeric size/nullable arbitrary color or title/message, plus host theme, reduced motion and state width. No focus action or dashed guide was introduced. Application code is unchanged.

Four macOS Alchemist tests reuse the sheets, precache the loading asset and settle frames with the existing DISABLE_INFINITE_ANIMATIONS test configuration. Reviewed all four baseline images and passed their comparison tests; strict analysis passed. An isolated Widgetbook check without the freeze flag verified live rotation, reduced-motion pause/resume, nullable color toggling, size handling and editable state content/width. No additional permanent interaction scenario test was added.

### PageHeader catalog and screenshots

Added grouped light/dark PageHeader sheets with six content/action compositions and a playground exposing title, supportingText and arbitrary actions through configurable button samples. Host width/theme and the existing native Focus preview support manual inspection. No production component changes, dashed guides or new interaction overrides were introduced.

Reviewed both baseline images; strict analysis and both Alchemist screenshot comparisons passed. An isolated Widgetbook check verified editable text, action count/labels/enablement, narrow width, native focus entry/Tab traversal and Escape return. No permanent per-issue test was added; application behavior remains unchanged.


### UI widget category organization

Reorganized lib/ui/widgets into base (buttons/tooltips), application (tabs, headers and status compositions), assets (icons and loading indicator), and internal (shared presentation helpers formerly under lib/ui/internal). These are presentation categories; domain state and page-specific coordination remain with their existing owners. Updated all imports/re-exports and ownership documentation. Screenshot directories follow the new component paths; existing PNGs were moved without regeneration. Widgetbook stories retain their existing controls and behavior.

Formatting made no changes; strict Flutter analysis and all 33 existing tests, including screenshot comparisons against the relocated baselines, passed. Whitespace checks passed. This is a file/import reorganization with no changes to component implementation, styling, animation or interaction policy; no new device acceptance is claimed.

### Widgetbook navigation categories

Grouped existing catalog entries with native WidgetbookFolder nodes: base (AppButton, AppTooltip), application (EmptyState, TabButton, HorizontalTabs, ThemeSelector, PageHeader, LoadingState), and assets (FeaturedIcon, LoadingIndicator). ThemeSelector remains Settings-owned. Existing use-case builders, sheets, playgrounds and screenshot tests are unchanged. Formatting, strict Flutter analysis and whitespace checks passed; screenshot tests were not rerun because their builders and inputs did not change.

### Widgetbook registration helpers

Extracted private _sheetUseCases and _component helpers in widgetbook/main.dart. The first preserves the light/dark story names and Theme → Material → vertical scroll → horizontal scroll → sheet hierarchy; the second combines those stories with the unchanged playground builder. AppButton retains explicit text/icon-only registration using the shared sheet helper. Folder/component/story order is unchanged. No sheet, playground, screenshot test or baseline changed. Formatting, strict Flutter analysis and whitespace checks passed; screenshot tests were not rerun because their shared sheets and inputs are untouched.

### Shared catalog playground theme

Extracted buildCatalogTheme in widgetbook/internal/catalog_theme.dart and reused it in the nine ordinary playgrounds. The function returns the same Theme → Material tree without adding an element or changing descendant layout, focus, knobs or reduced-motion scope. ThemeSelector retains its separate AnimatedTheme implementation. Catalog navigation, sheets, screenshot tests and baselines are untouched. Formatting, strict Flutter analysis and whitespace checks passed; no screenshot rerun was needed for unchanged sheet inputs.

### Catalog sheet theme reuse

_sheetUseCases now reuses buildCatalogTheme, preserving Theme → Material → vertical scroll → horizontal scroll → sheet. Navigation, story names, sheets, playgrounds and screenshot tests are unchanged. Formatting, strict Flutter analysis and whitespace checks passed. Screenshot tests were not rerun for this equivalent wrapper extraction.


### AppIcon catalog and screenshots

Added assets/AppIcon with grouped light/dark sheets (48 samples per theme across eight icons, four sizes, explicit and inherited colors), plus a playground exposing name, size and nullable color. Reuses the existing icon list and catalog theme wrapper. Invalid preview sizes show guidance; no production change, focus action or dashed guide was added. Existing stories and screenshots are unchanged.

Strict analysis passed. Generated and visually reviewed both macOS baselines, then passed both screenshot comparisons with SVG precaching and native frame settling. Whitespace checks passed. No application or interaction behavior changed; this does not claim live browser/device verification.

### AppIcon sheet example reuse

Moved the six example configurations outside the icon-row loop, once per build. Theme-derived colors are still resolved on each build. Strict analysis and both existing light/dark screenshot comparisons passed without baseline updates. Playground options and screenshot tests are unchanged.

### TabsSelect catalog and screenshots

Added standalone application/TabsSelect sheets, playground and two macOS screenshot tests. Six examples per theme cover both sizes, two selections and disabled controls. The playground exposes all consumed presentation/selection inputs, item editing, callback enablement, host width/theme and native focus preview. Production widgets and existing HorizontalTabs coverage are unchanged.

Strict analysis passed. Both baselines were visually reviewed and passed subsequent screenshot comparisons. An isolated Widgetbook check passed native menu selection, size/label/enabled knob changes, recovery after removing the selected item, focus entry/Escape return and disabled callback wiring. Initial harness failures were resolved by targeting menu Text rather than knob editors and checking the native focused node rather than duplicated dropdown label subtrees; no application fix was needed. No permanent per-issue test added. Whitespace checks passed.

### TabsSelect sheet sample reuse

Made the fixed example list const and reused one catalogTabItems() result per build across all six sheet controls. Playground options, screenshot tests and baselines remain unchanged. Formatting, strict analysis and both existing light/dark screenshot comparisons passed without baseline updates; whitespace checks passed.

### Focused catalog coverage policy

Removed PageHeader's dedicated screenshot tests/baselines while retaining its manual sheet and playground. AppIcon is now playground-only: removed its exhaustive icon sheets and dedicated tests/baselines. Removed standalone TabButton sheets/playground and its screenshot cases/baselines; HorizontalTabs and ThemeSelector coverage remain intact. Parent coverage is not a claim of exhaustive interaction or standalone vertical-line/custom-hook coverage. Production components are unchanged.

Updated catalog documentation and maintenance guidance: standalone stories and screenshot matrices must justify their maintenance cost; neither every widget nor every asset requires one. Strict analysis and all 31 remaining tests passed without regenerating retained baselines. Whitespace checks passed.


### Remove redundant standalone visual coverage

Removed standalone TabsSelect sheets/playground/tests and both baselines; its controls remain accessible through HorizontalTabs mobile mode and its existing mobile screenshots. Removed LoadingIndicator and ThemeSelector sheets/tests/baselines while preserving their live playgrounds unchanged. Removed LoadingState screenshot coverage while retaining its manual sheets and playground. No production code, retained playground implementations, HorizontalTabs coverage or other screenshot matrices/baselines changed.

Reconciled the catalog guide, root README, feature-plan coverage note and AGENTS guidance to distinguish intentional omissions from pending work. Strict analysis and all 23 remaining tests passed without regenerating retained baselines. Whitespace checks passed.


### Representative icon-only button interaction coverage

Reduced icon-only interaction captures to primary at medium/default in both themes, preserving hover, mouse press, touch press and focus checks. Removed 16 secondary/tertiary icon-only interaction PNGs. All full icon-only sheets, text-button interactions and retained baselines remain unchanged; production and catalog implementation are untouched. Updated catalog documentation and maintenance guidance. Strict analysis and all four button screenshot tests passed without baseline regeneration; whitespace checks passed.


### Representative tab and empty-state matrices

Reduced HorizontalTabs from 44 to 30 examples per theme: all style/size combinations retain intrinsic and full-width/slot views; four overflow examples cover undecorated and decorated surfaces, two examples cover whole-control disablement, and all four existing mobile size/enabled combinations remain. Every desktop group still contains an individually disabled item. Reduced EmptyState from 12 to six examples: all sizes without actions, medium one-action, small two-action, and large narrow/wrapping two-action compositions. This preserves all size recipes and representative action spacing/wrapping without the full cross-product.

Only the two sheets, their four baselines and documentation changed. Playground controls, sample action helper, production UI/behavior, test implementations and other matrices remain unchanged. Strict analysis passed; all four updated PNGs were visually reviewed. All four subsequent screenshot comparisons and whitespace checks passed.


### Widgetbook coverage review criteria

Documented parent-coverage checks, representative case selection and independent decisions for playgrounds, manual sheets and screenshot tests in AGENTS.md and the structure-gate test-review policy. Explicitly distinguish intentional omissions from pending work, composition coverage from duplicated child interactions, and settled screenshots from motion evidence. Reconciled outdated coverage statements in that policy. Documentation only: no catalog, test, baseline or production changes. Reviewed consistency and local links; whitespace checks passed.

### Catalog registration and explicit example configuration

Made _component's sheet optional and reused it for ThemeSelector, AppIcon and LoadingIndicator playground-only entries, preserving navigation/story order and existing wrappers. HorizontalTabs sheet examples now use a private enum with explicit label, width, full-width, slot, overflow, enabled and mobile fields instead of interpreting display strings. EmptyState example records carry their primary action label directly. Playground implementations, production widgets, screenshot tests and baselines are unchanged.

Formatting and strict analysis passed. All four tab/empty-state light/dark comparisons passed against existing baselines without regeneration. Whitespace checks passed.


### Exclude incomplete select variants from Widgetbook

Removed the four mobile select examples from HorizontalTabs sheets and removed the mobile breakpoint knob and its preview plumbing. Desktop tab examples (26 per theme) and controls are retained. The standalone TabsSelect entry had already been removed. Production widgets and Widgetbook's own knob editors remain unchanged. Updated current coverage guidance to mark the built-in select popup incomplete rather than covered through the parent.

Strict analysis passed; both updated desktop-only baselines were visually reviewed. Both screenshot comparisons and whitespace checks passed.

### Widgetbook source folders

Moved catalog sheets/playgrounds into component-owned directories matching golden ownership paths: ui/widgets/base, application and assets; Settings ThemeSelector uses app/pages/settings/theme_selector. Component files are sheet.dart/playground.dart, with HorizontalTabs examples.dart alongside them. Shared catalog helpers reside in support; main.dart remains the entry point. Updated all catalog/test imports and documentation references. No production logic, catalog navigation, story behavior, test coverage or screenshot baselines changed.

Formatting, strict analysis, all 23 existing tests (including screenshot comparisons) and whitespace checks passed.

### Catalog icon-option ownership

Renamed support/button_options.dart to support/catalog_icons.dart, retaining the shared icon list and removing its AppButton import. The icon-only hierarchy list is now the private _iconButtonHierarchies constant in AppButton's sheet.dart, its sole consumer. Updated playground imports. Coverage, navigation, fixtures, production behavior and baselines are unchanged. Formatting, strict analysis, all four button screenshot comparisons and whitespace checks passed.

### Widgetbook internal helpers directory

Renamed widgetbook/support to widgetbook/internal and updated catalog imports and documentation paths. No helper logic, stories, coverage or production behavior changed. Formatting, strict analysis and whitespace checks passed; tests were not rerun for this import-only rename.

### Collapsed catalog navigation defaults

Set native Widgetbook isInitiallyExpanded to false for category folders and component groups, including AppButton's explicit registration. No custom expansion state or navigation handling was introduced. Story contents and application behavior are unchanged. Formatting, strict analysis and whitespace checks passed; screenshot inputs are unaffected.

### Remove PageHeader catalog stories

Removed PageHeader's navigation entry, sheet and playground, including their unused sample fixtures. The production PageHeader remains unchanged. Updated catalog and coverage guidance to record the intentional absence of standalone stories/tests. Existing screenshot coverage is unaffected. Formatting, strict analysis and whitespace checks passed.

## Widgetbook scope completion and documentation reconciliation — 2026-11-14

The current component-catalog scope is complete. Retained automated visual coverage uses grouped light/dark AppButton text/icon-only, EmptyState, FeaturedIcon, AppTooltip and HorizontalTabs sheets, plus medium-default button hover/focus/mouse-press/touch-press captures (all text hierarchies and representative primary icon-only). LoadingState retains manual sheets and a playground; AppIcon, LoadingIndicator and Settings ThemeSelector retain playgrounds. TabButton relies on parent coverage; PageHeader has no standalone stories. TabsSelect and the HorizontalTabs mobile select mode remain excluded because their built-in popup is incomplete. These intentional coverage choices do not create additional catalog tasks.

The catalog guide is the current coverage reference; earlier entries in this log remain historical records of additions, reductions and verification. The plan now records this completed milestone, and the design records Widgetbook/Alchemist and catalog ownership. README and AGENTS formatting commands include Widgetbook sources. Discovery-origin details, breed catalog, full-flow/platform acceptance and delivery remain pending; no new page-flow screenshot requirement is introduced.

This reconciliation changes documentation only: application code, catalog code, tests and screenshot baselines are unchanged. Documentation consistency, local links and whitespace were checked; no application tests or builds were rerun for this update. Historical verification results remain attached to their original entries.

### Rename test helper directory

Renamed `test/support` to `test/internal`, updated the discovery test import and current coverage documentation. Helper contents, test scenarios, screenshot coverage and application behavior are unchanged. All nine discovery tests passed after allowing Flutter SDK cache access; whitespace checks passed.

### Share visual test configuration and settling

Extracted the repeated Alchemist theme/platform/shadow configuration and 16ms/five-second animation settling into `test/internal/visual_test.dart`. All five visual suites reuse these helpers; suite registration, paths, builders, input sequences and tooltip dismissal polling/default settling remain unchanged. The helper has an empty entry point because Flutter discovers the requested `_test.dart` filename; it registers no scenarios. No application or catalog implementation or screenshot baselines changed. The full suite passed all 23 tests against existing baselines. Strict analysis passed after removing imports made unused by extraction; formatting and whitespace checks passed.

### Simplify visual helper discovery and button theme reuse

Renamed the shared helper to `test/internal/visual_helpers.dart`, updated suite imports and catalog documentation, and removed its empty entry point. Button tests create one configuration per theme/family and reuse its theme in the existing MaterialApp wrapper. Coverage, screenshot paths/baselines, tooltip dismissal timing and application behavior are unchanged. All 23 tests passed against existing screenshots; strict analysis, formatting and whitespace checks passed.

### Updated Figma app icon and dedicated loading components — 2026-11-14

Inspected the current file through the local Cat tinder agent plugin after the hosted connector reached its Starter-plan limit. Exported the original app icon (`200:23599`) and loading graphics from all twelve variants of Loading indicator (`198:19234`); no Figma nodes were modified. The header replaces the monochrome paw with the 24px cat-and-heart Amber-gradient icon, preserving its layout. Launcher/release assets remain pending delivery work.

LoadingState now represents the dedicated component with line-simple/line-spinner/dot-circle styles, sm/md/lg/xl sizing, optional single supporting text and token-based colors/typography. Discovery uses line-simple/md on desktop and sm on mobile, centered in initial and photo-loading areas without the old empty-state heading/message/top padding. Original SVG dimensions and overflow are retained. Removed unsupported Display P3 CSS declarations from exports and mapped fallback colors to existing theme tokens after render inspection exposed invisible loaders and black branding.

The compact button LoadingIndicator retains its original graphic and interface. Its existing one-second linear rotation lifecycle is shared under ui/widgets/internal with LoadingState, including reduced-motion stopping and screenshot-only reset. Existing LoadingState manual sheets and playground controls were updated to the new interface; no permanent screenshot suites or coverage were added. API, voting, recovery, readiness and navigation logic are unchanged.

Validation: all 23 retained tests passed against existing screenshot baselines; strict analysis, Dart formatting and whitespace checks passed. Isolated temporary harnesses rendered all twelve loading variants and branding in light/dark, checked 390px/1440px loading placement, and verified live rotation, reduced-motion stop/resume, optional text and wrapping. Rendered previews were inspected against plugin exports. These checks do not claim Android/browser live acceptance or completion of details/catalog features.

### Platform appearance and application metadata — 2026-11-14

Applied the existing Figma app icon to Android legacy/adaptive launchers, iOS and macOS icon catalogs, Windows multi-resolution ICO, Linux window/desktop assets, and web favicon/touch/PWA icons. Added opaque iOS artwork and padded maskable/adaptive versions using the original cat silhouette and Amber gradient. Source PNGs and a Pillow-based size generator are documented under assets/branding. No new runtime dependency or design artwork was introduced.

Visible platform names are Cat tinder; descriptions use “Discover cat photographs and explore their breeds.” Updated Android strings/manifest, Apple bundle display metadata, desktop window titles and Windows resource descriptions; removed template publisher/copyright claims. Existing package IDs and executable identities remain unchanged. macOS product/scheme/test-host references were reconciled with its visible app name. Linux bundles carry desktop/icon files for subsequent desktop installation. Web manifest uses branded colors, relative scope/start/id and unrestricted orientation; HTML includes title, description, application/social metadata, touch icon and a launch mark removed on Flutter's first frame. Android/iOS launch images use the same artwork.

Verification: web release compilation and Android debug APK compilation passed using config.test.json (no service credentials). APK badging confirms Cat tinder and the adaptive icon resource. Apple plists/project syntax, Android/storyboard XML, icon dimensions/opacity, manifest asset references and whitespace passed; icon previews were inspected. The web build retains its existing missing Cupertino font warning. Full Xcode is unavailable, so Apple platform builds were not run; Windows/Linux native builds and installed-device launch acceptance remain unverified. This completes platform branding, not release signing, release APK acceptance, media or publication. Product features and test/screenshot coverage are unchanged.

### Package-owned platform branding generation — 2026-11-14

Replaced `tool/generate_app_icons.py` with `icons_launcher` 3.1.0 and `flutter_native_splash` 2.4.8 development dependencies and root YAML configurations. Checked-in artwork variants retain the original opaque iOS tile, macOS clearance, Android adaptive safe area and web maskable geometry. `tool/generate_branding.sh` invokes both packages and preserves application-owned platform policies through metadata restoration and a narrow compatibility patch. No application Dart code, startup hold, UI transition or runtime splash dependency was added. Web still dismisses the splash on `flutter-first-frame`; native first-frame lifecycle remains unchanged.

The package's fixed-color/window-policy output would alter existing native appearance, so the compatibility patch retains Android system backgrounds, iOS systemBackgroundColor and the existing accessible web loading label. The wrapper preserves Info.plist and Android styles and keeps Android 12's OS-default launcher splash. The generator's restrictive viewport tag is removed to retain existing web metadata. Linux Snapcraft generation is disabled; the existing Linux desktop icon/packaging and web Apple touch icon remain checked in. Source/export exceptions and package-upgrade review instructions are recorded in `assets/branding/README.md`.

Verification: repeated the full regeneration command successfully; compared platform metadata against the pre-migration snapshot (unchanged); verified adaptive foreground dimensions at all five densities and 96px base launch images; visually compared representative before/after raster assets. Artwork is retained with package resampling differences; favicon output is 48px and Windows ICO gains a 96px representation. Strict Flutter analysis, web release build and Android debug APK build with `config.test.json` passed. APK inspection confirms the Cat tinder label and adaptive launcher resource. The web build retains its pre-existing Cupertino font warning. No application/test coverage changes were needed. Live startup on devices and iOS/macOS/Windows/Linux builds were not verified in this migration; release acceptance remains pending.

### Branding generator cleanup — 2026-11-14

Configured `info_plist_files: []` to skip plist edits through the package itself and removed plist backup/restore from the wrapper. Android style preservation now includes existing light/dark Android 12 files; generated files are removed only where the corresponding file was absent before generation. The exit trap restores those policies on success and generator failure. Removed whitespace-only compatibility-patch edits and the seven unused Android/iOS background asset files; regeneration removes these assets after their references have been replaced with native system backgrounds.

Verification: shell syntax and whitespace checks passed. Full package regeneration succeeded, with all retained native assets and metadata byte-identical to the pre-cleanup snapshot; web output differed only in formatting. The project's absent Android 12 style files remained absent. An isolated temporary harness with stub generators verified that all four pre-existing style files survive both successful execution and a generator failure. No permanent tests, application code, icons, appearance recipes or first-frame timing changed. No new device startup verification was performed; earlier platform acceptance limitations remain applicable.

### Dot-circle opacity animation — 2026-11-14

Changed LoadingState's dot-circle style from clockwise whole-image rotation to a counterclockwise opacity sequence over stationary dots. Native circle painting retains each size's exported count (11/16/19/22), radius, center and visible overflow, with the existing brand foreground and initial opacity ramp. Circle geometry was checked against the checked-in SVG coordinates (rounding differences below 0.001 logical pixel). The one-second controller lifecycle is shared through LoadingAnimation; LoadingRotation continues to serve the unchanged line styles and compact button spinner. Reduced motion stops the sequence, and screenshot configuration resets it to the original phase. No SVG assets or discovery behavior changed.

Validation: Flutter formatting, strict analysis, all 23 retained tests including existing button screenshots, and whitespace checks passed. No new per-issue test suite was added. Live animation appearance has not been device-verified in this change.

### Content-sized loading cursor — 2026-11-14

LoadingState now places its wait-cursor MouseRegion inside a centered, shrink-wrapping Align. The parent can retain its allocated area while the hover region fits the indicator/text column instead of inheriting the full container width. Native constraints still bound long text. AppButton retains its state-resolved wait cursor; no shared cursor helper or custom pointer tracking is needed. Animation geometry, controller lifecycle, reduced-motion handling and screenshot resets are unchanged. Formatting, strict analysis and whitespace checks passed; no new UI regression tests were added.
