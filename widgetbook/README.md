# Component catalog and screenshots

The current Widgetbook scope is complete. Retained screenshot families are AppButton, EmptyState, FeaturedIcon, AppTooltip and HorizontalTabs, with the manual sheets and playgrounds described below. Intentional omissions are not pending catalog work. The incomplete select popup remains excluded; page-flow automation is outside this scope. Full-application usability, platform acceptance and unfinished product features remain in the [development plan](../openspec/changes/define-product-baseline/tasks.md).

## Source organization

Catalog sources mirror the component paths used by screenshot folders, without platform or light/dark directories because both themes share the same Dart stories:

```text
widgetbook/
  main.dart
  internal/                       # shared catalog theme, focus, guides and options
  ui/widgets/
    base/{app_button,app_tooltip}/
    application/{empty_state,horizontal_tabs,loading_state}/
    assets/{app_icon,featured_icon,loading_indicator}/
  app/pages/settings/theme_selector/
```

Each component folder contains `playground.dart` and, where retained, `sheet.dart`. HorizontalTabs also owns `examples.dart`. Playground-only components follow the same ownership paths even without goldens. `main.dart` remains the entry point; navigation and story names are independent of these source paths. Screenshot files and coverage are unchanged.


Run from the project root, without API configuration:

```sh
flutter run -d chrome --target widgetbook/main.dart
flutter test --dart-define-from-file=config.test.json --exclude-tags visual
flutter test --dart-define-from-file=config.test.json test/visual
```

The catalog imports the production AppButton and theme. `ui/widgets/base/app_button/sheet.dart` is the single sheet shared by Widgetbook and Alchemist: five hierarchies × five sizes × five examples (default, leading icon, trailing icon, disabled, loading), 125 cells per theme. The catalog scrolls the sheet; tests render it eagerly at its full size. AppButton icon-only mode has its own sheets using the same renderer: three supported hierarchies × five sizes × default/disabled/loading, 45 cells per theme. Both sheet forms render the same production AppButton. Other retained component families and intentional exclusions are described below.

The four button grouped tests generate 52 images: 42 for text buttons and 10 for icon-only buttons. Each family retains its full sheet per light/dark theme. Hover/focus/mouse-press/touch-press crops use the existing medium/default cells: every text-button hierarchy and only primary for icon-only buttons. Primary represents icon-only interaction geometry; secondary/tertiary recipes remain in the full sheets and text-button interaction coverage. Hover and mouse press use a mouse pointer; touch press uses a touch pointer; focus uses keyboard Tab traversal. Press captures keep the pointer down until native animation frames settle, then release it and settle feedback before continuing. No widget states or production internals are overridden. Crops include cell padding for shadows/focus outlines. The tests do not assert individual colors, dimensions or private helper structure.

## Baseline environment and review

Baselines in `test/visual/goldens/macos/ui/widgets/base/app_button/{light,dark}/` use macOS, Flutter 3.47.8, DPR 1, real bundled Inter/fonts and SVG icons, rendered shadows, and exact image comparison. Alchemist's text-obscuring CI goldens are disabled. Other hosts do not execute these macOS visual variants; use the reference environment for comparison and approval. Keep the resolved dependency lockfile. Do not treat browser/Android rendering as verified by these goldens.

The visual suites share their Alchemist configuration and animation-settling helper in `test/internal/visual_helpers.dart`; suite-specific rendering and interactions remain in each test file. Tooltip dismissal retains its existing polling and default settling timing.

Every capture waits for Flutter’s `pumpAndSettle`: frames advance in 16ms steps until no frame is scheduled, with a five-second failure timeout rather than an estimated animation delay. Held touch captures wait for ink expansion to finish; release cleanup also settles before the next interaction. The checked-in `config.test.json` sets the compile-time `DISABLE_INFINITE_ANIMATIONS` flag. The shared `disableInfiniteAnimations` constant resets and stops the shared LoadingAnimation used by the compact button spinner and dedicated LoadingState; button transitions remain enabled and settle normally. Normal application and Widgetbook commands omit this file and animate as before. The visual harness fails early with the required command if the flag is missing. New animation checks are added explicitly where needed; the flag does not intercept Flutter or package animations globally. This covers settled states, not intermediate motion or asynchronous work that does not schedule frames. Update images only after inspecting the resulting differences.

```sh
flutter test --dart-define-from-file=config.test.json test/visual --update-goldens
flutter test --dart-define-from-file=config.test.json test/visual
```

Review the changed PNGs before accepting them. Failures produce comparison artifacts; do not blindly regenerate baselines to silence a failure. These initial images record the existing application appearance and were checked for harness rendering errors, not newly approved against Figma. Interactive stories allow manual inspection of all sizes; automated hover/focus/press captures cover medium defaults across all text-button hierarchies and primary icon-only buttons.

Widgetbook and Alchemist are dev dependencies. The catalog has its own entry point and does not run application startup, Riverpod discovery, API operations or saved preferences. Widgetbook brings url_launcher transitively, so Flutter updates generated platform plugin registration; no production widget or behavior is changed.

## Single-button playground

The AppButton **Playground** exposes label, size, non-nullable hierarchy (primary by default), nullable leading/trailing icons, iconOnly, loading/loadingLabel and callback enablement. A separate dark-theme knob controls the surrounding theme. Nullable icon controls let you restore the actual null defaults. Hierarchy is the single appearance selector; there are no primary/link aliases. Invalid icon-only combinations show a short explanation instead of triggering the constructor assertion; values are not silently coerced. Hover and keyboard focus are exercised directly on the rendered button. The playground does not add screenshot cases or modify the sheets.

Use **Focus preview** in the playground to focus the enabled example without activating it. Native Tab/Shift+Tab traversal stays inside the preview scope; Escape returns focus to the catalog action, outside that scope. Disabled, loading or invalid examples display guidance and do not enter the scope. The action remains keyboard reachable. Focus nodes and the Escape handler belong only to the catalog wrapper; AppButton exposes no forced-focus state.

Icon examples use the Figma `Icons/placeholder` asset (14:5). The playground selects it by default when enabling either nullable icon control; the initial icon values remain null, matching AppButton. The SVG retains the local-plugin export geometry and proportional stroke (1⅔px at 20px).

## Icon-only buttons

The AppButton catalog includes light/dark icon-only sheets alongside its text-button sheets. Use the same Playground: enable an icon, then turn on iconOnly. All AppButton options remain exposed, including label, size, hierarchy, loading/loadingLabel and callback enablement; invalid link-hierarchy or missing-icon combinations display guidance. The icon-only sheets explicitly set their hierarchy and size; AppButton constructor defaults remain primary/extra-large. There is no separate AppIconButton widget or playground.

Screenshot folders mirror the widget path under the platform directory, followed by the theme. For AppButton, `text_sheet.png` and `icon_only_sheet.png` hold grouped variants; interaction captures use names such as `text_primary_hover.png` and `icon_only_primary_touch_pressed.png`.

## EmptyState

EmptyState has grouped light/dark sheets and a Playground. Each sheet has six representative examples: no actions at all three sizes, medium with one action, small with two actions, and large with two actions in a 200px-wide wrapping composition. This preserves size-specific typography/spacing and both action-spacing recipes without crossing every layout with every size. It renders the production widget and AppButton action slots with the placeholder icon. The playground exposes title, message, icon, size and the actions slot through zero/one/two sample actions with editable labels and enablement. Theme and preview width are host controls, not EmptyState properties; the actions slot remains an arbitrary widget list in production. Focus preview traverses enabled actions.

Two additional grouped tests capture fully settled sheets at `test/visual/goldens/macos/ui/widgets/application/empty_state/{light,dark}/variants.png`. They cover composition, spacing and wrapping rather than duplicating AppButton interaction captures. Application-owned recovery flows are not covered by these sheets; FeaturedIcon has separate coverage below.

## FeaturedIcon

FeaturedIcon has light/dark theme sheets with all 44 supported combinations per sheet: four sizes × (light/dark styles in five colors, plus modern gray). Component style and application theme are independent. Sheets use the placeholder asset and render the production FeaturedIcon. The Playground exposes icon, size, color and style with constructor defaults (large, gray, modern), plus a host dark-theme control. Unsupported modern/non-gray selections show guidance without silently coercing inputs. This decorative widget has no hover, press or focus behavior to duplicate.

Two settled screenshot tests store the sheets at `test/visual/goldens/macos/ui/widgets/assets/featured_icon/{light,dark}/variants.png`. Page-flow screenshots are outside the completed component-catalog scope.

## AppTooltip sheets and playground

AppTooltip has grouped light/dark sheets with all seven arrow placements, each with message-only and supporting-text content (14 examples per theme). Each example uses the production AppTooltip directly in a native local overlay, sharing the same synchronous sizing, positioning, styling and interactions as the application. Hover or long-press its target in Widgetbook to reveal it.

The two screenshot tests open all examples with independent mouse devices. They poll for observable tooltip appearance through the hover-delay timer, then settle entrance animations before capture; pointer removal and exit cleanup also settle. Baselines live in `test/visual/goldens/macos/ui/widgets/base/app_tooltip/{light,dark}/variants.png`. These sheets cover centered targets, not automated viewport-edge or touch-interaction acceptance.

The Playground exposes every presentation option: message, supportingText with an explicit enable toggle, arrow, four viewportPadding edge sliders (default zero), viewportMaxWidth with an unlimited default and a finite-width slider, and sample Text/Button/Icon content for the arbitrary child slot. Host controls select theme and target position, including viewport corners for manual collision checks. The production 500ms hover delay and long-press behavior remain unchanged. No visibility controller or test-only option was added to AppTooltip.

## Constrained preview boundaries

The catalog-only ConstrainedPreview draws a 1px dashed `borderSecondary` guide around explicit host constraints: EmptyState widths and tooltip collision viewports, in sheets and playgrounds. It adds no padding, clipping, semantics or hit target, so the guide does not change wrapping or package placement. Intrinsically sized buttons/icons are not outlined merely because they occupy a catalog grid cell.

The tooltip supporting-text enable toggle deliberately uses a boolean plus text knob. Widgetbook 3.25.0's `defaultToNull` nullable-string value and checkbox use different conditions when another knob populates the query group, so that control can display an unchecked box while returning its initial string. The explicit toggle supplies null reliably without resetting the entered text.

AppTooltip now uses native overlay-local geometry, so no catalog positioning subclass or coordinate workaround is needed. Forui owns final sliding and target-aligned arrow rendering; AppTooltip selects available space and constrains scrollable content synchronously. Preferred corner anchors remain intact when they fit. Content is suppressed only when no space beyond its padding remains or the target is outside the visible overlay. The dashed preview boundary remains catalog-only.


## HorizontalTabs

HorizontalTabs retains grouped light/dark sheets and a playground. Its 26 desktop examples per theme retain intrinsic and full-width-with-slots compositions for all five desktop styles at both sizes (20 examples), representative overflow for underline/small, minimal/medium, border/medium and brand/small (four), and fully disabled underline/small and gray/medium (two). Decorated minimal/border overflow remains represented; individual disabled items still appear in every desktop group. The playground exposes desktop presentation, selection, item fields and tooltip boundaries; the breakpoint knob is intentionally omitted. Two screenshot tests capture these grouped horizontal_tabs sheets.

There is no standalone TabButton story or screenshot suite. Shared tab rendering is reviewed through HorizontalTabs and Settings ThemeSelector. This does not imply exhaustive automated interaction coverage or coverage of the standalone vertical-line style and custom callback samples.

## ThemeSelector

ThemeSelector has its own **Playground**, rendering the Settings-owned component separately from TabButton/HorizontalTabs. Clicking Light/Dark/System updates local selection and the preview's AnimatedTheme using MaterialApp's default theme duration and linear curve. It does not start the application, use Riverpod or read/write saved preferences. The catalog sidebar is unaffected.

The value knob sets the starting selection when Widgetbook rebuilds the preview; clicks then control local selection. The onChanged sample can update selection or do nothing (the required callback remains non-null and the buttons remain interactive). Host controls provide Device/Light/Dark system brightness, preview width and reduced motion. System follows the actual device unless simulated. Focus preview retains native Tab/Shift+Tab traversal and Escape return. No dashed boundary is rendered. The playground remains the interactive transition story.

ThemeSelector is playground-only. Its theme-transition and input behavior is inspected interactively; static sheets and dedicated screenshot tests are intentionally omitted because settled gray-tab styling overlaps HorizontalTabs.

## LoadingIndicator and LoadingState

LoadingIndicator is playground-only. Its controls expose numeric size (default 32), nullable color override and arbitrary color picker, plus host theme and reduced motion. Invalid negative/non-finite sizes show guidance. There are no spinner variant sheets or dedicated screenshots: frozen size/color samples add little beyond loading-button coverage and cannot verify rotation.

LoadingState follows the dedicated Figma loading component: line-simple, line-spinner and dot-circle styles; sm/md/lg/xl sizes; and optional supporting text. It retains manual light/dark sheets with standard copy, long wrapping copy and a narrow 200px host, plus its playground for style, size, nullable text, width, theme and reduced motion. It has no dedicated screenshot tests. Both loading playgrounds preserve normal rotation and native reduced-motion handling; neither adds a focus action or dashed guide.

PageHeader intentionally has no standalone stories or screenshot tests; its simple text/action composition is inspected in application context.

Navigation groups existing stories under `base`, `application` and `assets`, matching the UI widget categories. Settings-owned ThemeSelector is included under `application` for catalog discovery; its production ownership remains in the Settings page. Sheets, playground controls and screenshot paths are unchanged by this navigation grouping.


## AppIcon

The assets/AppIcon entry is playground-only, exposing name, numeric size (default 20), and nullable color through an override toggle and color picker. It reuses the catalog icon list and selects placeholder initially. Invalid sizes show guidance. There are no grouped icon sheets or dedicated screenshot tests; enumerating every icon would scale poorly without protecting distinct interaction contracts. Icons remain visible in their parent components' screenshots.

## TabsSelect

TabsSelect and HorizontalTabs' mobile select mode are excluded from Widgetbook and screenshots because their built-in options popup is incomplete relative to the intended design. No standalone select entry, mobile sheet examples or mobile breakpoint knob remains. Production select implementation is unchanged; complete its design before restoring catalog coverage. Widgetbook's own dropdown knob editors are unaffected.

Navigation folders and expandable component groups start collapsed using Widgetbook's native `isInitiallyExpanded: false` setting. Users can expand them normally; story names and routes are unchanged.
