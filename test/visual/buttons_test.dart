import 'package:cat_tinder/environment.dart';
import 'package:alchemist/alchemist.dart';
import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/app_button.dart';
import 'package:cat_tinder/ui/widgets/app_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widgetbook/button_sheet.dart';

void main() {
  for (final dark in [false, true]) {
    final mode = dark ? 'dark' : 'light';
    AlchemistConfig.runWithConfig(
      config: AlchemistConfig(
        theme: appTheme(
          variables: UiVariables(colors: UiColors(dark: dark)),
        ),
        platformGoldensConfig: PlatformGoldensConfig(
          platforms: {HostPlatform.macOS},
          renderShadows: true,
        ),
        ciGoldensConfig: const CiGoldensConfig(enabled: false),
      ),
      run: () => goldenTest(
        'AppButton grouped variants ($mode)',
        fileName: 'buttons_$mode',
        tags: ['visual'],
        builder: () => const ButtonSheet(),
        pumpWidget: (tester, widget) => tester.pumpWidget(
          MaterialApp(
            theme: appTheme(
              variables: UiVariables(colors: UiColors(dark: dark)),
            ),
            home: widget,
          ),
        ),
        pumpBeforeTest: (tester) async {
          expect(
            disableInfiniteAnimations,
            isTrue,
            reason:
                'Run screenshots with --dart-define-from-file=config.test.json',
          );
          await tester.runAsync(
            () => AppIcon.precache(['placeholder', 'loading']),
          );
          await _settle(tester);
        },
        whilePerforming: (tester) async {
          // Use the existing default cells. Native input determines their state.
          for (final hierarchy in AppButtonHierarchy.values) {
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
            await _settle(tester);
            await expectLater(
              cell,
              matchesGoldenFile(
                'goldens/macos/buttons_${mode}_${hierarchy.name}_hover.png',
              ),
            );
            await mouse.down(tester.getCenter(button));
            await _settle(tester);
            await expectLater(
              cell,
              matchesGoldenFile(
                'goldens/macos/buttons_${mode}_${hierarchy.name}_mouse_pressed.png',
              ),
            );
            await mouse.up();
            await mouse.removePointer();
            await _settle(tester);

            final touch = await tester.startGesture(
              tester.getCenter(button),
              kind: PointerDeviceKind.touch,
            );
            // Keep the pointer down until native ink expansion has finished.
            await _settle(tester);
            await expectLater(
              cell,
              matchesGoldenFile(
                'goldens/macos/buttons_${mode}_${hierarchy.name}_touch_pressed.png',
              ),
            );
            await touch.up();
            await touch.removePointer();
            await _settle(tester);

            // Traverse with the keyboard, rather than forcing WidgetState.focused.
            var focused = false;
            for (var step = 0; step < 125; step++) {
              await tester.sendKeyEvent(LogicalKeyboardKey.tab);
              await tester.pump();
              final focusContext = FocusManager.instance.primaryFocus?.context;
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
            await _settle(tester);
            await expectLater(
              cell,
              matchesGoldenFile(
                'goldens/macos/buttons_${mode}_${hierarchy.name}_focus.png',
              ),
            );
            FocusManager.instance.primaryFocus?.unfocus();
            await _settle(tester);
          }
          return null;
        },
      ),
    );
  }
}

Future<void> _settle(WidgetTester tester) async {
  await tester.pumpAndSettle(
    const Duration(milliseconds: 16),
    EnginePhase.sendSemanticsUpdate,
    const Duration(seconds: 5),
  );
}
