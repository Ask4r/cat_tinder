# Styling variables

The styling system follows Untitled UI React's separation of theme variables, inherited defaults and component recipes. Figma defines the project values; React defines behavior where Figma is silent.

## Organization

- `styles/color_definitions.dart`: the complete 622-color catalog as conventional typed Dart properties, including unused colors, imported Tailwind primitives, Light/Dark values and Figma defaults. Examples: `brand600`, `textPrimary`, `bgBrandSolid`, `backgroundColorBrandSolid`. Aliases directly reference other properties; there is no string registry, operator overload or CSS-name lookup. All properties support named constructor and `copyWith` overrides. Project brand values use sRGB equivalents converted from the Figma export’s Display P3 profile; imported OKLCH coordinates are defined in extended sRGB and converted to Display P3 before reaching widgets, because Flutter’s native color tweens reject extended sRGB.
- `styles/variables.dart`: `UiVariables`, a Flutter `ThemeExtension` containing semantic colors, a four-pixel spacing unit, radii, paired typography sizes/line heights, and complete shadow/inset effects. Values support copying and interpolation for inherited theme changes.
- `theme.dart`: installs these variables into `ThemeData` and adapts them to native text, icon, surface and color-scheme defaults.
- `widgets/app_button.dart`: the button composes its appearance and states from the shared variables in the same file as the widget. There are no separate component-style files. Loading behavior likewise stays in its widget file.
- `widgets/app_icon.dart`, `widgets/featured_icon.dart`, and `widgets/loading_indicator.dart`: reusable icon rendering, framed icons, and loading animation. They consume UI configuration and contain no application state.
- `app/layouts/application_layout.dart`: owns ApplicationLayout (width/breakpoint decisions) and ApplicationFrame (shared gutters and width constraints). The shell composes pages separately. Pages own their photograph dimensions and other screen-specific measurements.

Widgets read `context.ui.colors`, `context.ui.text`, `context.ui.space(n)`, `context.ui.radii` and `context.ui.effects`. Spacing is composed from the shared unit: `space(4)` is 16px in the default theme. Equal numeric values do not establish a shared semantic relationship: a featured icon's 48px container does not refer to button sizing.

Effects are complete recipes (`shadowXs`, `shadowSecondaryXs`, `skeuomorphic`), not separate globally exposed alpha/offset/blur constants. Component painters receive the resolved effect and radius; they do not reach into a global palette. Typography uses the design-system scale: `textXs`, `textSm`, `textMd`, `textLg`, `textXl`, and `displayXs` through `display2xl`. Each style defines its font family, size, line height and tracking. The scale does not assign title/body/label meaning or semibold weight; components compose those choices explicitly. Flutter's `TextTheme` role names appear only in the native-theme adapter in `theme.dart`.

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
- [button.tsx](https://github.com/untitleduico/react/blob/207c26b47595bf39d9467265055623e1c7082294/components/base/buttons/button.tsx): component-local variants and shared style composition. The application deliberately uses Flutter’s native FilledButton, OutlinedButton and TextButton interaction behavior, including ripple, easing and focus feedback, as preferred by the user. AppButton owns only UI interaction state: a native WidgetStatesController, pointer presence and the current press device. MouseRegion restores hover when a disabled button becomes enabled under a stationary pointer; Listener identifies the press device. No custom animation controller or painter is used. ButtonStyle.backgroundBuilder receives native interaction states and composes standard Ink decorations for the fill, border and focus ring, with a standard ShaderMask for the primary gradient stroke and a rounded bottom border for the inset shadow. The inset uses a full-size DecoratedBox, so both edges follow the button radius without an Ink strip escaping the corners. A built-in ColorTween animates the fill over 100ms (zero with reduced motion). Hover overlays are transparent to preserve the specified hover color; primary and secondary press ripples use the same background color as their hover state. Touch presses leave the base fill unchanged while native ink supplies the feedback; mouse clicks retain the hovered background and use NoSplash. Touch presses use native InkRipple; cancelled primary/secondary ripples finish the normal native expansion/fade. Link buttons retain native press feedback. The secondary border remains borderPrimary at 1px and is drawn above the ripple. Ink decorations keep ripples visible. The shared outer shadow is retained.
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

The underline `TabButton` is an atomic UI control; the application shell owns destinations and selection. Its selected/hover underline uses `fgBrandPrimaryAlt`, with brand text, and inactive text uses `textQuaternary`. The current Figma focus variants have no distinct visible treatment. Its gray variant supplies the Settings appearance selector with externally owned selection.

Link buttons have zero outer and label padding and use their selected size's text scale. Optional leading/trailing icons use 16px at extra-small size and 20px otherwise, 60% opacity and 4px gaps. Disabled button opacity applies to the complete composed button, including outline and effects, matching the Figma component's 50% opacity.

## Complete horizontal tabs family

`HorizontalTabs<T>` represents Figma Horizontal tabs (29:1007): underline, minimal, border, gray and brand; small/medium sizes; content-width/full-width rows; desktop/mobile variants (40 combinations). The mobile variant delegates to `TabsSelect<T>` and Flutter's native dropdown. The host explicitly selects the breakpoint variant: the application's current mobile designs intentionally use the desktop-style row for navigation and appearance selection.

`TabButton` represents the underlying tab base: underline, vertical line, brand, gray, white and minimal, in both sizes and selected/unselected states. Native button states resolve default, hover and focus recipes from shared variables. Leading icons and badges are optional unmanaged presentation slots. HorizontalTabs maps its border style to white tab buttons and owns group spacing, surface, border and overflow. `TabItem<T>` provides the value, label, enabled flag, optional slots, tooltip and semantic identifier. Domain selection and navigation stay in the app.

Tabs use 200ms linear transitions for text/icon color, hover fills and fixed indicators. Gray tabs reveal the selected background after 225ms, matching the native ripple expansion; deselection fades over 200ms. Touch press does not additionally animate the base background. A color-only InkRipple adapter follows theme changes during expansion and fading, while Flutter owns the ripple lifecycle. Each TabButton owns its Figma selected fill, underline or vertical line, outline and shadow. Hover and focus recipes are retained. Underline tabs use no ripple and never gain a background; the other variants use native smooth InkRipple press feedback. Reduced motion updates colors immediately. HorizontalTabs is stateless: no marker anchors, layout measurements, shared moving indicators or navigation Hero flights. Mobile dropdown variants retain native select behavior.

Both ApplicationShell navigation and Settings appearance selection use HorizontalTabs; neither reconstructs a tab group inline. The select chevron is exported from Figma 108:8530. Focus shadows remain unclipped in scrollable rows. Underline tabs have no focus outline, matching the accepted Figma design. All other variants, including vertical-line tabs, retain their focus outline.

## Other component families

| Component | Supported Figma variants |
| --- | --- |
| `AppButton` | Five sizes, primary/secondary/tertiary/link-color/link-gray, default/hover/focused/disabled/loading (125 combinations) |
| `AppIconButton` | Five sizes, primary/secondary/tertiary, the same five states (75 combinations) |
| `AppTooltip` | Seven arrow placements, with/without supporting text (14 combinations) |
| `FeaturedIcon` | Four sizes; light/dark in five colors and modern gray (44 combinations) |
| `EmptyState` | Small, medium and large; externally supplied actions |
| `PageHeader` | Simple desktop/mobile, which share one recipe, with optional actions |

Button hierarchy and size are presentation options. Flutter owns hover, focus, press and keyboard behavior; callers supply loading and enabled state. Loading replaces the icons with the shared spinner and blocks activation without applying disabled opacity. Icon buttons reuse the button recipe and require an accessible label. Existing primary/secondary interaction and geometry refinements are retained, including stable geometry where Figma's small/medium primary default and focused masters disagree on inset padding.

Tooltips use Forui's FTooltip for gestures, long-press release timing, overlay placement, collision handling and target-aligned arrows. The stateless AppTooltip maps the shared Figma variables to FTooltipStyle and supplies accessibility semantics. Its only geometry adapter is FPortalSpacing: the 8px target-edge gap plus 6px arrow height, with a fixed 20px corner inset for bottom-left/right. This runs before Forui's flip/slide handling; childCenter arrows follow the final target geometry. Corner insets may adjust near collisions to keep pointing at the target. No target measurement, viewport algorithm, arrow painter, controller or dismissal timer is application-owned. The wrapper supplies Forui's accessibility scope and preserves reduced-motion behavior. Supporting text remains bounded to 320px including padding; text wraps on smaller screens. Hover appearance is delayed by 500ms unless TooltipTheme supplies another wait duration. Long presses remain visible while held and dismiss 1.5 seconds after release unless TooltipTheme supplies another duration. Figma colors, 8px radius, 16×6px sharp arrow, padding, typography and layered shadows remain sourced from shared variables.

Discover and Settings consume `PageHeader`; application branding and responsive header sizing remain in `app/layouts/application_header.dart`. LoadingIndicator accepts size/color for reuse inside buttons; it retains its reduced-motion behavior. Component recipes stay beside their widgets and consume the shared variables.
