# Discovery implementation evidence

Current scope: development-plan slice 1, subsequently authorized Settings appearance selection, and retained root-tab navigation. Earlier sections below record historical implementation stages and their checks; later decisions supersede them. Current behavior is defined by the capability specs and lib/ui/README.md. Reviewed working-tree changes against base commit `ac42237b75552e96431957cdc1aca472d9aacfa6`; no commit or publication is performed by this task.

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

Subsequent responsibility-only changes extracted private background/content helpers within AppButton and TabButton, consolidated icon-only semantics, and retained the existing native button/ripple adapters and interaction-state owners. DiscoveryLoading and DiscoveryRecovery now share a private status frame with explicit padding differences. TabItem lives in ui/widgets/tab_item.dart, imported by both tab consumers and re-exported from horizontal_tabs.dart to preserve callers. This removes the group/selector import cycle.

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

Authorized Widgetbook 3.25.0 and Alchemist 0.14.1 as dev dependencies. widgetbook/button_sheet.dart builds the actual AppButton in 125 combinations (five hierarchies, five sizes, default/leading icon/trailing icon/disabled/loading) shared by the scrollable light/dark catalog and full-sheet capture. The visual runner uses native mouse input and keyboard traversal on medium/default examples for each hierarchy, recording padded cell crops instead of duplicating stories or asserting internal styling properties. Two grouped tests produce 22 PNGs: two full sheets and 20 hover/focus crops.

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
