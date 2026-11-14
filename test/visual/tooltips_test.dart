import 'package:alchemist/alchemist.dart';
import 'package:cat_tinder/ui/widgets/base/app_tooltip.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../widgetbook/ui/widgets/base/app_tooltip/sheet.dart';

import '../internal/visual_helpers.dart';

void main() {
  for (final dark in [false, true]) {
    final mode = dark ? 'dark' : 'light';
    AlchemistConfig.runWithConfig(
      config: visualTestConfig(dark: dark),
      run: () => goldenTest(
        'AppTooltip grouped variants ($mode)',
        fileName: 'ui/widgets/base/app_tooltip/$mode/variants',
        tags: ['visual'],
        builder: () => const TooltipSheet(),
        whilePerforming: (tester) async {
          final mice = <TestGesture>[];
          // Independent mouse devices keep each real tooltip open for the sheet.
          for (final arrow in TooltipArrow.values) {
            for (final supporting in [false, true]) {
              final mouse = TestGesture(
                dispatcher: tester.sendEventToBinding,
                kind: PointerDeviceKind.mouse,
                device: mice.length + 1,
              );
              mice.add(mouse);
              await mouse.addPointer(location: Offset.zero);
              await mouse.moveTo(
                tester.getCenter(
                  find.byKey(ValueKey(tooltipTargetId(arrow, supporting))),
                ),
              );
            }
          }
          // Hover delay is a timer, not an animation: wait for observable tips
          // before settling their entrance transitions.
          final deadline = tester.binding.clock.fromNowBy(
            const Duration(seconds: 5),
          );
          while (find.text(tooltipMessage).evaluate().length != 14 &&
              tester.binding.clock.now().isBefore(deadline)) {
            await tester.pump(const Duration(milliseconds: 16));
          }
          expect(find.text(tooltipMessage), findsNWidgets(14));
          await settleAnimations(tester);
          return () async {
            for (final mouse in mice) {
              await mouse.removePointer();
            }
            final deadline = tester.binding.clock.fromNowBy(
              const Duration(seconds: 5),
            );
            while (find.text(tooltipMessage).evaluate().isNotEmpty &&
                tester.binding.clock.now().isBefore(deadline)) {
              await tester.pump(const Duration(milliseconds: 16));
            }
            expect(find.text(tooltipMessage), findsNothing);
            await tester.pumpAndSettle();
          };
        },
      ),
    );
  }
}
