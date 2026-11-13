# Button catalog and screenshots

Run from the project root, without API configuration:

```sh
flutter run -d chrome --target widgetbook/main.dart
flutter test --dart-define-from-file=config.test.json --exclude-tags visual
flutter test --dart-define-from-file=config.test.json test/visual
```

The catalog imports the production AppButton and theme. `button_sheet.dart` is the single sheet shared by Widgetbook and Alchemist: five hierarchies × five sizes × five examples (default, leading icon, trailing icon, disabled, loading), 125 cells per theme. The catalog scrolls the sheet; tests render it eagerly at its full size. AppIconButton and other component families are not included yet.

Two grouped tests generate 42 images: one full sheet per light/dark theme and hover/focus/mouse-press/touch-press crops of the existing medium/default cell for each hierarchy. Hover and mouse press use a mouse pointer; touch press uses a touch pointer; focus uses keyboard Tab traversal. Press captures keep the pointer down until native animation frames settle, then release it and settle feedback before continuing. No widget states or production internals are overridden. Crops include cell padding for shadows/focus outlines. The tests do not assert individual colors, dimensions or private helper structure.

## Baseline environment and review

Baselines in `test/visual/goldens/macos/` use macOS, Flutter 3.47.8, DPR 1, real bundled Inter/fonts and SVG icons, rendered shadows, and exact image comparison. Alchemist's text-obscuring CI goldens are disabled. Other hosts do not execute these macOS visual variants; use the reference environment for comparison and approval. Keep the resolved dependency lockfile. Do not treat browser/Android rendering as verified by these goldens.

Every capture waits for Flutter’s `pumpAndSettle`: frames advance in 16ms steps until no frame is scheduled, with a five-second failure timeout rather than an estimated animation delay. Held touch captures wait for ink expansion to finish; release cleanup also settles before the next interaction. The checked-in `config.test.json` sets the compile-time `DISABLE_INFINITE_ANIMATIONS` flag. The shared `disableInfiniteAnimations` constant currently resets and stops only LoadingIndicator rotation; button transitions remain enabled and settle normally. Normal application and Widgetbook commands omit this file and animate as before. The visual harness fails early with the required command if the flag is missing. New animation checks are added explicitly where needed; the flag does not intercept Flutter or package animations globally. This covers settled states, not intermediate motion or asynchronous work that does not schedule frames. Update images only after inspecting the resulting differences.

```sh
flutter test --dart-define-from-file=config.test.json test/visual --update-goldens
flutter test --dart-define-from-file=config.test.json test/visual
```

Review the changed PNGs before accepting them. Failures produce comparison artifacts; do not blindly regenerate baselines to silence a failure. These initial images record the existing application appearance and were checked for harness rendering errors, not newly approved against Figma. Interactive stories allow manual inspection of all sizes; automated hover/focus/press captures cover medium defaults across all five hierarchies.

Widgetbook and Alchemist are dev dependencies. The catalog has its own entry point and does not run application startup, Riverpod discovery, API operations or saved preferences. Widgetbook brings url_launcher transitively, so Flutter updates generated platform plugin registration; no production widget or behavior is changed.

## Single-button playground

The third AppButton case, **Playground**, exposes label, size, non-nullable hierarchy (primary by default), nullable leading/trailing icons, iconOnly, loading/loadingLabel and callback enablement. A separate dark-theme knob controls the surrounding theme. Nullable icon controls let you restore the actual null defaults. Hierarchy is the single appearance selector; there are no primary/link aliases. Invalid icon-only combinations show a short explanation instead of triggering the constructor assertion; values are not silently coerced. Hover and keyboard focus are exercised directly on the rendered button. The playground does not add screenshot cases or modify the two sheets.

Use **Focus preview** in the playground to focus the enabled example without activating it. Native Tab/Shift+Tab traversal stays inside the preview scope; Escape returns focus to the catalog action, outside that scope. Disabled, loading or invalid examples display guidance and do not enter the scope. The action remains keyboard reachable. Focus nodes and the Escape handler belong only to the catalog wrapper; AppButton exposes no forced-focus state.

Icon examples use the Figma `Icons/placeholder` asset (14:5). The playground selects it by default when enabling either nullable icon control; the initial icon values remain null, matching AppButton. The SVG retains the local-plugin export geometry and proportional stroke (1⅔px at 20px).
