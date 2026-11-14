# Styling variables

The styling system follows Untitled UI React's separation of theme variables, inherited defaults and component recipes. Figma defines the project values; React defines behavior where Figma is silent.

## Organization

- `styles/color_definitions.dart`: the complete 622-color catalog as conventional typed Dart properties, including unused colors, imported Tailwind primitives, Light/Dark values and Figma defaults. Examples: `brand600`, `textPrimary`, `bgBrandSolid`, `backgroundColorBrandSolid`. Aliases directly reference other properties; there is no string registry, operator overload or CSS-name lookup. All properties support named constructor and `copyWith` overrides. Project brand values use sRGB equivalents converted from the Figma export’s Display P3 profile; imported OKLCH coordinates are defined in extended sRGB and converted to Display P3 before reaching widgets, because Flutter’s native color tweens reject extended sRGB.
- `styles/variables.dart`: `UiVariables`, a Flutter `ThemeExtension` containing semantic colors, a four-pixel spacing unit, radii, paired typography sizes/line heights, and complete shadow/inset effects. Values support copying and interpolation for inherited theme changes.
- `theme.dart`: installs these variables into `ThemeData` and adapts them to native text, icon, surface and color-scheme defaults.
- `widgets/base/app_button.dart`: the button composes its appearance and states from the shared variables in the same file as the widget. There are no separate component-style files. Loading behavior likewise stays in its widget file.
- `widgets/assets/app_icon.dart`, `widgets/assets/featured_icon.dart`, and `widgets/assets/loading_indicator.dart`: reusable icon rendering, framed icons, and loading animation. They consume UI configuration and contain no application state.
- `app/layouts/application_layout.dart`: owns ApplicationLayout (width/breakpoint decisions) and ApplicationFrame (shared gutters and width constraints). The shell composes pages separately. Pages own their photograph dimensions and other screen-specific measurements.

Widgets read `context.ui.colors`, `context.ui.text`, `context.ui.space(n)`, `context.ui.radii` and `context.ui.effects`. Spacing is composed from the shared unit: `space(4)` is 16px in the default theme. Equal numeric values do not establish a shared semantic relationship: a featured icon's 48px container does not refer to button sizing.

Effects are complete recipes (`shadowXs`, `shadowSecondaryXs`, `skeuomorphic`), not separate globally exposed alpha/offset/blur constants. Component painters receive the resolved effect and radius; they do not reach into a global palette. Typography uses the design-system scale: `textXs`, `textSm`, `textMd`, `textLg`, `textXl`, and `displayXs` through `display2xl`. Each style defines its font family, size, line height and tracking. The scale does not assign title/body/label meaning or semibold weight; components compose those choices explicitly. Flutter's `TextTheme` role names appear only in the native-theme adapter in `theme.dart`.

The `widgets` directory is grouped into `base` (AppButton and AppTooltip), `application` (tabs and their item/select controls, PageHeader, EmptyState and LoadingState), `assets` (AppIcon, FeaturedIcon and LoadingIndicator), and `internal` (shared implementation helpers). These are presentation categories, not new state or dependency layers: `application` widgets still accept their content and selection from callers and do not access application state. Raw SVG/font files remain in the project assets directory.

## Theme scope

Configure the whole application through `appTheme(variables: ...)`. For a subtree, derive the current variables and install a scoped `Theme`:

```dart
final inherited = context.ui;
final scoped = inherited.copyWith(
  colors: inherited.colors.copyWith(bgBrandSolid: customBrandColor),
);
return Theme(
  data: appTheme(variables: scoped),
  child: child,
);
```

Using `appTheme` also updates native Flutter defaults. Components listen to the inherited theme and rebuild when it changes; sibling scopes remain unchanged. UI widgets remain independent of application state. Settings supplies an app-wide Light/Dark/System preference through Riverpod and retains it across launches. In System mode, the app follows device brightness through `ThemeMode.system`, with light and dark themes built from `UiColors()` and `UiColors(dark: true)`. The adapter sets matching native theme and color-scheme brightness. The default Light values are checked in, not live-synchronized with Figma. The generic widgets have a Light fallback when hosted without the application extension.

## Reference and precedence

1. Project Figma variables, component variants and styles define appearance.
2. Untitled UI React supplies behavior not specified by the design.
3. Choices absent from both sources remain with their owning component or layout.

React reference: commit `207c26b47595bf39d9467265055623e1c7082294`.

- [theme.css](https://github.com/untitleduico/react/blob/207c26b47595bf39d9467265055623e1c7082294/styles/theme.css): primitives, semantic aliases, typography and complete effects.
- [globals.css](https://github.com/untitleduico/react/blob/207c26b47595bf39d9467265055623e1c7082294/styles/globals.css): shared defaults and inherited transition behavior.
- [typography.css](https://github.com/untitleduico/react/blob/207c26b47595bf39d9467265055623e1c7082294/styles/typography.css): scoped composition of theme variables.
- [button.tsx](https://github.com/untitleduico/react/blob/207c26b47595bf39d9467265055623e1c7082294/components/base/buttons/button.tsx): component-local variants and shared style composition. The application deliberately uses Flutter’s native FilledButton, OutlinedButton and TextButton interaction behavior, including ripple, easing and focus feedback, as preferred by the user. AppButton owns only UI interaction state: a native WidgetStatesController, pointer presence and the current press device. MouseRegion restores hover when a disabled button becomes enabled under a stationary pointer; Listener identifies the press device. No custom animation controller or painter is used. ButtonStyle.backgroundBuilder receives native interaction states and composes standard Ink decorations for the fill, border and focus ring, with a standard ShaderMask for the primary gradient stroke and a rounded bottom border for the inset shadow. The inset uses a full-size DecoratedBox, so both edges follow the button radius without an Ink strip escaping the corners. A built-in ColorTween animates the fill over 100ms (zero with reduced motion). Hover overlays are transparent to preserve the specified hover color; primary and secondary press ripples use the same background color as their hover state. Touch presses leave the base fill unchanged while native ink supplies the feedback; mouse clicks retain the hovered background and use NoSplash. Touch presses use native InkRipple; cancelled primary/secondary ripples finish the normal native expansion/fade. Link buttons keep transparent backgrounds and overlays in every state, suppress ripples, and fade their label underline on hover using the native text-style transition. The underline stays in the text style with a transparent color outside hover, allowing Flutter to interpolate its color over the same 100ms duration (zero under reduced motion). The secondary border remains borderPrimary at 1px and is drawn above the ripple. Ink decorations keep ripples visible. The shared outer shadow is retained.
- [loading-indicator.tsx](https://github.com/untitleduico/react/blob/207c26b47595bf39d9467265055623e1c7082294/components/application/loading-indicator/loading-indicator.tsx): continuous linear rotation. The Flutter adaptation stops rotation and removes transition duration under reduced-motion settings.

The complete color catalog is retained whether or not a color currently appears in a component. Reference variable names are adapted to Dart lowerCamelCase rather than copied with CSS prefixes. For example, `colors.copyWith(brand600: newColor)` updates the source of `bgBrandSolid`, utility aliases and property aliases. `colors.copyWith(bgBrandSolid: newColor)` overrides just that semantic role and its dependents. Unrelated overrides preserve existing alias links. Misspelled properties are compile-time errors.


Network timing and queue behavior are application concerns, outside the styling system.

The project brand palette uses sRGB equivalents converted from the Figma export’s embedded Display P3 profile, so web rendering preserves the intended appearance. Button visual density is explicitly standard on every platform; decorative stacks pass through layout constraints to preserve content centering and the selected size’s height (48px for extra-large buttons).

Icons use a 2px stroke at 24px and scale proportionally (20px → 1⅔px; 16px → 1⅓px). Each icon has one SVG asset. In Figma, use the Scale tool when changing icon sizes so strokes scale along with geometry; ordinary resizing does not scale stroke widths.

Button labels use even line-height leading to center the glyphs relative to their icons, matching Figma’s line-box positioning without per-label offsets.

When syncing SVG exports, retain their standard color fallbacks and remove unsupported CSS color(display-p3 …) declarations before Flutter rendering. Geometry and proportional strokes remain unchanged.

Cross-layer dependencies use `package:cat_tinder/...` imports (for example, app → ui/state and state → api). Same-layer imports may remain relative. Shared widgets live in `ui/widgets`; theme and styling definitions remain in `ui/theme.dart` and `ui/styles`. Discovery cards, domain-specific loading/recovery compositions and application navigation remain owned by the application.

Focused buttons retain their normal border and show the Figma 2px focusRing outline separated by a 2px gap. The outline uses a standard outside-aligned border and does not alter layout. Hover transitions use native button interaction states. The splash factory suppresses mouse ripples and retains native InkRipple for touch; passive pointer events supply only the device distinction.

Primary and secondary buttons specialize only the native default/theme overlay fallback. A null pressed overlay allows the native transparent pressed highlight and scoped theme splash color to operate independently, avoiding a whole-surface fade alongside the ripple. Hover and focus overlays remain transparent. Flutter continues to own button state, semantics, keyboard activation and ink animation.

Empty states compose the reusable `EmptyState` widget with the modern `FeaturedIcon`, bounded text, and wrapping actions. Discovery owns the message, retry/skip behavior, responsive size choice, and surrounding surface. Mobile uses the small empty state with 36px buttons; desktop uses medium with 40px buttons. The alert-circle asset comes from the Figma icon component. Failed photographs use the secondary surface and side-by-side Skip photo / Try again actions; discovery request errors use a centered full-card recovery surface. Specific configuration and timeout explanations remain available in the same layout.

The underline `TabButton` is an atomic UI control; the application shell owns destinations and selection. Its selected/hover underline uses `fgBrandPrimaryAlt`, with brand text, and inactive text uses `textQuaternary`. The current Figma focus variants have no distinct visible treatment. Settings uses a page-owned ThemeSelector with the same gray-tab recipe and externally owned selection.

Link buttons have zero outer and label padding and use their selected size's text scale. Optional leading/trailing icons use 16px at extra-small size and 20px otherwise, 60% opacity and 4px gaps. Disabled button opacity applies to the complete composed button, including outline and effects, matching the Figma component's 50% opacity.

## Complete horizontal tabs family

`HorizontalTabs<T>` represents Figma Horizontal tabs (29:1007): underline, minimal, border, gray and brand; small/medium sizes; content-width/full-width rows; desktop/mobile variants (40 combinations). The mobile variant delegates to `TabsSelect<T>` and Flutter's native dropdown. The host explicitly selects the breakpoint variant: the application's current mobile designs intentionally use the desktop-style row for navigation and appearance selection.

`TabButton` represents the underlying tab base: underline, vertical line, brand, gray, white and minimal, in both sizes and selected/unselected states. Native button states resolve default, hover and focus recipes from shared variables. Leading icons and badges are optional unmanaged presentation slots. HorizontalTabs maps its border style to white tab buttons and owns group spacing, surface, border and overflow. `TabItem<T>` provides the value, label, enabled flag, optional slots, tooltip and semantic identifier. Domain selection and navigation stay in the app.

Tabs use 100ms linear transitions for text/icon color, hover fills and fixed indicators. Shared gray tabs use the same ColorTween path as other fills, with no theme-specific ripple adapter or delayed selection reveal. Touch press does not additionally animate the base background. Settings alone owns the theme-control overrides described below. Each TabButton owns its Figma selected fill, underline or vertical line, outline and shadow. Hover and focus recipes are retained. Underline tabs use no ripple and never gain a background; the other variants use native smooth InkRipple for touch and keyboard activation. Mouse presses suppress both the ripple and pressed overlay, using passive pointer down/up/cancel observation like AppButton; hover, focus and gesture recognition remain native. Reduced motion updates colors immediately. HorizontalTabs is stateless: no marker anchors, layout measurements, shared moving indicators or navigation Hero flights. Mobile dropdown variants retain native select behavior.

ApplicationShell navigation uses HorizontalTabs. Settings uses its page-owned ThemeSelector, a fixed Light/Dark/System row reusing gray TabButtons. The select chevron is exported from Figma 108:8530. Focus shadows remain unclipped in scrollable rows. Underline and vertical-line tabs have no focus outline, matching Figma. Button-style variants retain their focus outline. Unselected gray tabs remain transparent on hover; their text/icon color still transitions, and focus retains its separate background recipe.

## Other component families

| Component | Supported Figma variants |
| --- | --- |
| `AppButton` | Five sizes, primary/secondary/tertiary/link-color/link-gray, default/hover/focused/disabled/loading (125 combinations) |
| `AppButton(iconOnly: true)` | Five sizes, primary/secondary/tertiary, the same five states (75 combinations) |
| `AppTooltip` | Seven arrow placements, with/without supporting text (14 combinations) |
| `FeaturedIcon` | Four sizes; light/dark in five colors and modern gray (44 combinations) |
| `EmptyState` | Small, medium and large; externally supplied actions |
| `PageHeader` | Simple desktop/mobile, which share one recipe, with optional actions |

Button hierarchy and size are presentation options. Flutter owns hover, focus, press and keyboard behavior; callers supply loading and enabled state. Loading replaces the icons with the shared spinner and blocks activation without applying disabled opacity. Icon buttons reuse the button recipe and require an accessible label. Existing primary/secondary interaction and geometry refinements are retained, including stable geometry where Figma's small/medium primary default and focused masters disagree on inset padding.

Tooltips use Flutter's `OverlayPortal.overlayChildLayoutBuilder` for synchronous target/overlay geometry. AppTooltip owns the local hover/long-press timers and native animation controller; Flutter owns gesture recognition, overlay attachment, focus and content scrolling. A private render layout measures and constrains the content within available space in the same frame. It preserves the preferred anchors when they fit, tries opposite/perpendicular sides, then constrains the content to a roomy side with native scrolling. Forui's public `FPortalOverflow.slide` calculates final placement, and `FPortalArrowDecoration` owns arrow orientation, drawing and target alignment. There is no Forui fork, post-frame geometry observer or catalog coordinate adapter. Sheets and playgrounds use production AppTooltip directly inside native local overlays.

ApplicationFrame and tooltip consumers share `ApplicationLayout.containerPadding(context)`: `space(4)` on mobile and `space(8)` on desktop (16px/32px under the default variables). App consumers also pass `ApplicationLayout.maxWidth` as `viewportMaxWidth` (1280px). HorizontalTabs forwards both options to its item tooltips; discovery supplies them directly. AppTooltip centers that maximum-width boundary within its actual safe overlay, then applies viewportPadding during its existing synchronous layout pass. No inherited boundary configuration or application-level geometry measurement is needed. ApplicationShell places `Overlay.wrap` directly around the full-width scrollable below the header, preserving the card's paint area, gutter scrolling, tab transitions and scroll restoration. Only tooltip sizing is restricted to the frame. Standalone/catalog defaults are zero padding and unlimited width.

`AppTooltip.viewportPadding` accepts nonnegative `EdgeInsets` (default `EdgeInsets.zero`) and insets the tooltip body boundary within the nearest overlay, in addition to safe-area/keyboard insets. It is independent of content padding and target spacing. Targets within the reserved margin remain usable; available side dimensions are capped to the inset viewport. Arrow adjustment and decorative shadows retain their existing rendering.

The design spacing remains an 8px target-edge gap plus 6px arrow clearance, with the 20px inset for bottom-left/right anchors. Supporting text is bounded to 320px including padding. The target is not covered when content needs constraining; if there is no space beyond the padding, or the target leaves the visible overlay, the body/arrow is suppressed instead of overflowing. Hover appears after 500ms (TooltipTheme waitDuration overrides it); hovering the visible tip keeps it open, with a 100ms exit grace period. Long presses remain visible while held and dismiss 1500ms after release (TooltipTheme showDuration overrides it). Native fades last 150ms in and 75ms out, use linear curves and honor reduced motion. Focusable targets can reveal the tip; Escape dismisses it. Figma colors, 8px radius, sharp 16×6px arrow, typography, padding and shadows are unchanged. Flutter's synchronous geometry API does not support a CompositedTransformFollower ancestor between the target portal and its overlay; current consumers do not use that arrangement.

Discover and Settings consume `PageHeader`; application branding and responsive header sizing remain in `app/layouts/application_header.dart`. LoadingIndicator accepts size/color for reuse inside buttons; it retains its reduced-motion behavior. Component recipes stay beside their widgets and consume the shared variables.

AppButton selects its hierarchy through one non-nullable `AppButtonHierarchy`, defaulting to `primary`. The former `primary`/`link` aliases are removed. Existing secondary and link application buttons declare their hierarchy explicitly. The Widgetbook playground mirrors this interface; nullable controls are used only for nullable inputs.

Tertiary hover fills interpolate from the hover color at zero opacity, avoiding an intermediate gray flash from transparent black. The native hover state and existing 100ms fill transition remain unchanged.

Tertiary mouse presses suppress the native pressed overlay as well as the splash, preserving only the hover fill. Touch and keyboard pressed feedback use a scoped bgPrimaryHover splash color with null overlay fallbacks, preserving Flutter’s transparent pressed highlight. This avoids a whole-button highlight alongside the ripple. Flutter continues to own the ripple animation. This uses the existing passive press-device observation; no gesture handling is added.

Loading AppButton controls (including link/icon variants) use SystemMouseCursors.progress. Otherwise, disabled AppButton and TabButton controls resolve the native disabled state to SystemMouseCursors.forbidden. Enabled cursors retain the native/theme defaults; no pointer tracking or gesture overrides are added for cursor selection.

Dark FeaturedIcon variants use the same shared shadowXs and skeuomorphic recipe as the Figma primary-button master: 2px fading white highlight stroke, 2px bottom inset and 1px inner outline. Standard rounded decorations and ShaderMask compose these effects without a custom painter. Their radii are 6/8/10/12px across small through extra-large. UiRadii now distinguishes xs (4px) from sm (6px); existing link/tab and modern-small recipes retain their previous 4px geometry via xs.

Light-style FeaturedIcon foregrounds use featuredIconLightFgGray/Brand/Success/Warning/Error. These preserve the light-theme colors and resolve to the lighter 200-level palette in dark theme. The current Figma collection has only a Light mode; the dark mapping follows the dedicated imported semantic tokens.

TabButton leading slots merge their size into the animated IconTheme, preserving foreground color inheritance through selection, hover and theme changes. HorizontalTabs uses a paint-only ClipRect for non-full-width rows, driven by the native ScrollPosition. It retains vertical clearance for the focus outline and shadow blur, plus horizontal clearance at the content ends only; scrolled content stays clipped at the viewport edges. Clearance derives from the existing shadow effects with a 4px focus-outline minimum. No padding, scroll extent, controller or gesture handling is added. Full-width rows, mobile selects, selection timing and ripple behavior are unchanged.

White/border and minimal tabs composite their opaque selected fill, border and shadow in one native AnimatedOpacity layer, fading together over 100ms. This surface sits below TextButton’s Material, so text, focus decoration and ripples remain independent and visible. The opaque fill covers the shadow interior before compositing, preventing the dark flash. Shadow effects retain their shared tokens and can paint outside the button bounds, subject to the tab viewport clearance. The other variants retain their selection behavior.

Brand tab touch/keyboard feedback uses bgBrandPrimaryAlt, matching its selected surface instead of the generic gray pressed tint. Gray tabs use bgPrimaryHover; white/border and minimal tabs use bgPrimaryAlt. These filled variants match their selected surfaces on held touch. Vertical-line tabs retain their translucent foreground ripple because they have no filled selection surface; underline tabs remain ripple-free. Mouse ripple suppression and selection timing are unchanged.

Settings `theme_selector.dart` owns the theme-change specialization: focus/selection amounts interpolate against the live AnimatedTheme colors, and a color-only InkRipple subclass follows those colors even after release. Mouse selection fades over 100ms; touch/keyboard selection reveals after 225ms of native ripple expansion, while deselection fades over 100ms. Reduced motion skips these transitions. ThemeSelector supplies these overrides through TabButton’s optional fillAnimationBuilder and rippleFactoryBuilder hooks. TabButton owns the shared recipe, text transitions, focus outline, selected semantics and passive pointer-device policy; Flutter owns gestures, hover, focus and ink lifecycle. The fill hook receives resolved colors, selection/focus state, activation mode and reduced-motion-aware duration, and returns animation through the shared paint callback. It does not replace button geometry or focus decoration. The ripple hook receives a live color getter; shared mouse suppression and underline ripple suppression still take precedence. Default TabButton behavior contains no theme-control policy.

Minimal tab groups paint the selected tab before its siblings so its opaque surface cannot cover a neighboring focus ring across the 2px gap. A private Row/RenderFlex specialization changes child paint order only; native flex layout, hit testing, semantics and overflow handling are retained. The existing viewport clip still limits scrolled content and preserves decoration clearance at content ends. Other tab styles keep normal Row painting.

## Internal implementation helpers

`ui/widgets/internal/pointer_feedback.dart` shares passive press-device observation between AppButton and TabButton. Each state owns its helper instance; it builds the same Listener without a notifier, gesture recognizer, timer or extra widget state. Hover presence and stationary-pointer enablement remain AppButton-owned, and retained mouse-overlay suppression remains TabButton-owned.

`ui/widgets/internal/delegating_ripple_factory.dart` resolves a component-supplied factory at activation and forwards Flutter's ink arguments, optionally resolving its initial color. AppButton chooses NoSplash, native InkRipple or its private cancellation-fade factory. TabButton chooses NoSplash, native InkRipple or its caller's factory, retaining its device policy before color resolution. Settings' live-theme ripple adapter stays in Settings. Styling, 100ms transitions, focus decoration and native gesture/ink lifecycle are unchanged; these helpers are internal machinery, not new catalog components.

`ui/widgets/internal/focus_ring.dart` shares the ignored-pointer, 2px outside focus border and native opacity transition between AppButton and TabButton. Owners supply visibility, radius, color and duration. `ui/widgets/internal/gradient_highlight_stroke.dart` shares the ignored-pointer ShaderMask and rounded 2px highlight border between AppButton and FeaturedIcon, receiving the existing gradient and radius. Positioned.fill wrappers, stack order, clipping, base borders, bottom insets and shadows stay in each component. These helpers neither detect focus nor handle input and do not add public component variants.
