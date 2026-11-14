import 'package:alchemist/alchemist.dart';
import 'package:cat_tinder/ui/widgets/assets/app_icon.dart';

import '../../widgetbook/ui/widgets/application/empty_state/sheet.dart';

import '../internal/visual_helpers.dart';

void main() {
  for (final dark in [false, true]) {
    final mode = dark ? 'dark' : 'light';
    AlchemistConfig.runWithConfig(
      config: visualTestConfig(dark: dark),
      run: () => goldenTest(
        'EmptyState grouped variants ($mode)',
        fileName: 'ui/widgets/application/empty_state/$mode/variants',
        tags: ['visual'],
        builder: () => const EmptyStateSheet(),
        pumpBeforeTest: (tester) async {
          await tester.runAsync(() => AppIcon.precache(['placeholder']));
          await settleAnimations(tester);
        },
      ),
    );
  }
}
