import 'package:alchemist/alchemist.dart';
import 'package:cat_tinder/ui/widgets/assets/app_icon.dart';

import '../../widgetbook/ui/widgets/application/horizontal_tabs/sheet.dart';

import '../internal/visual_helpers.dart';

void main() {
  for (final dark in [false, true]) {
    final mode = dark ? 'dark' : 'light';
    AlchemistConfig.runWithConfig(
      config: visualTestConfig(dark: dark),
      run: () => goldenTest(
        'HorizontalTabs grouped variants ($mode)',
        fileName: 'ui/widgets/application/horizontal_tabs/$mode/variants',
        tags: ['visual'],
        builder: () => const HorizontalTabsSheet(),
        pumpBeforeTest: (tester) async {
          await tester.runAsync(() => AppIcon.precache(['placeholder']));
          await settleAnimations(tester);
        },
      ),
    );
  }
}
