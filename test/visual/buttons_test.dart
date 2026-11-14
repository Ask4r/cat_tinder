import 'package:cat_tinder/environment.dart';
import 'package:alchemist/alchemist.dart';
import 'package:cat_tinder/ui/widgets/base/app_button.dart';
import 'package:cat_tinder/ui/widgets/assets/app_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widgetbook/ui/widgets/base/app_button/sheet.dart';

import '../internal/visual_helpers.dart';

void main() {
  for (final iconButtons in [false, true]) {
    final family = iconButtons ? 'AppButton icon-only' : 'AppButton';
    final prefix = iconButtons ? 'icon_only' : 'text';
    for (final dark in [false, true]) {
      final mode = dark ? 'dark' : 'light';
      final screenshotPath = 'ui/widgets/base/app_button/$mode';
      final config = visualTestConfig(dark: dark);
      AlchemistConfig.runWithConfig(
        config: config,
        run: () => goldenTest(
          '$family grouped variants ($mode)',
          fileName: '$screenshotPath/${prefix}_sheet',
          tags: ['visual'],
          builder: () => ButtonSheet(iconButtons: iconButtons),
          pumpWidget: (tester, widget) =>
              tester.pumpWidget(MaterialApp(theme: config.theme, home: widget)),
          pumpBeforeTest: (tester) async {
            expect(
              disableInfiniteAnimations,
              isTrue,
              reason: 'Run screenshots with --dart-define-from-file=config.test.json',
            );
            await tester.runAsync(
              () => AppIcon.precache(['placeholder', 'loading']),
            );
            await settleAnimations(tester);
          },
          whilePerforming: (tester) async {
            // Use the existing default cells. Native input determines their state.
            for (final hierarchy
                in iconButtons
                    ? const [AppButtonHierarchy.primary]
                    : AppButtonHierarchy.values) {
              final cell = find.byKey(
                ValueKey(
                  buttonCellId(
                    hierarchy,
                    AppButtonSize.md,
                    ButtonExample.defaultState,
                  ),
                ),
              );
              final button = find.descendant(
                of: cell,
                matching: find.byType(AppButton),
              );
              final mouse = await tester.createGesture(
                kind: PointerDeviceKind.mouse,
              );
              await mouse.addPointer(location: Offset.zero);
              await mouse.moveTo(tester.getCenter(button));
              await settleAnimations(tester);
              await expectLater(
                cell,
                matchesGoldenFile(
                  'goldens/macos/$screenshotPath/${prefix}_${hierarchy.name}_hover.png',
                ),
              );
              await mouse.down(tester.getCenter(button));
              await settleAnimations(tester);
              await expectLater(
                cell,
                matchesGoldenFile(
                  'goldens/macos/$screenshotPath/${prefix}_${hierarchy.name}_mouse_pressed.png',
                ),
              );
              await mouse.up();
              await mouse.removePointer();
              await settleAnimations(tester);

              final touch = await tester.startGesture(
                tester.getCenter(button),
                kind: PointerDeviceKind.touch,
              );
              // Keep the pointer down until native ink expansion has finished.
              await settleAnimations(tester);
              await expectLater(
                cell,
                matchesGoldenFile(
                  'goldens/macos/$screenshotPath/${prefix}_${hierarchy.name}_touch_pressed.png',
                ),
              );
              await touch.up();
              await touch.removePointer();
              await settleAnimations(tester);

              // Traverse with the keyboard, rather than forcing WidgetState.focused.
              var focused = false;
              for (var step = 0; step < 125; step++) {
                await tester.sendKeyEvent(LogicalKeyboardKey.tab);
                await tester.pump();
                final focusContext =
                    FocusManager.instance.primaryFocus?.context;
                if (focusContext?.findAncestorWidgetOfExactType<AppButton>() ==
                    tester.widget<AppButton>(button)) {
                  focused = true;
                  break;
                }
              }
              expect(
                focused,
                isTrue,
                reason: 'Default example must be keyboard reachable',
              );
              await settleAnimations(tester);
              await expectLater(
                cell,
                matchesGoldenFile(
                  'goldens/macos/$screenshotPath/${prefix}_${hierarchy.name}_focus.png',
                ),
              );
              FocusManager.instance.primaryFocus?.unfocus();
              await settleAnimations(tester);
            }
            return null;
          },
        ),
      );
    }
  }
}
