import 'package:alchemist/alchemist.dart';
import 'package:cat_tinder/ui/theme.dart';
import 'package:flutter_test/flutter_test.dart';

AlchemistConfig visualTestConfig({required bool dark}) => AlchemistConfig(
  theme: appTheme(
    variables: UiVariables(colors: UiColors(dark: dark)),
  ),
  platformGoldensConfig: PlatformGoldensConfig(
    platforms: {HostPlatform.macOS},
    renderShadows: true,
  ),
  ciGoldensConfig: const CiGoldensConfig(enabled: false),
);

Future<void> settleAnimations(WidgetTester tester) async {
  await tester.pumpAndSettle(
    const Duration(milliseconds: 16),
    EnginePhase.sendSemanticsUpdate,
    const Duration(seconds: 5),
  );
}
