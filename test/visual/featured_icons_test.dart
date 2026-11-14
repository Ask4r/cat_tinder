import 'package:alchemist/alchemist.dart';
import 'package:cat_tinder/ui/widgets/assets/app_icon.dart';

import '../../widgetbook/ui/widgets/assets/featured_icon/sheet.dart';

import '../internal/visual_helpers.dart';

void main() {
  for (final dark in [false, true]) {
    final mode = dark ? 'dark' : 'light';
    AlchemistConfig.runWithConfig(
      config: visualTestConfig(dark: dark),
      run: () => goldenTest(
        'FeaturedIcon grouped variants ($mode)',
        fileName: 'ui/widgets/assets/featured_icon/$mode/variants',
        tags: ['visual'],
        builder: () => const FeaturedIconSheet(),
        pumpBeforeTest: (tester) async {
          await tester.runAsync(() => AppIcon.precache(['placeholder']));
          await settleAnimations(tester);
        },
      ),
    );
  }
}
