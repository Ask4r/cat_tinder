import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cat_tinder/state/appearance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cat_tinder/app/layouts/application_router.dart';
import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/app_icon.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppIcon.precache(['search', 'alert-circle']);
  SharedPreferencesWithCache? preferences;
  try {
    preferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: {AppearancePreferences.storageKey},
      ),
    );
  } catch (error, stack) {
    log(
      'Could not restore appearance preference',
      error: error,
      stackTrace: stack,
    );
  }
  runApp(
    ProviderScope(
      overrides: [
        appearanceProvider.overrideWith(
          () => AppearancePreferences(preferences: preferences),
        ),
      ],
      child: const CatTinderApp(),
    ),
  );
}

class CatTinderApp extends ConsumerStatefulWidget {
  const CatTinderApp({super.key});
  @override
  ConsumerState<CatTinderApp> createState() => _CatTinderAppState();
}

class _CatTinderAppState extends ConsumerState<CatTinderApp> {
  final _router = ApplicationRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Cat tinder',
    debugShowCheckedModeBanner: false,
    theme: appTheme(),
    darkTheme: appTheme(
      variables: const UiVariables(colors: UiColors(dark: true)),
    ),
    themeMode: switch (ref.watch(appearanceProvider)) {
      Appearance.light => ThemeMode.light,
      Appearance.dark => ThemeMode.dark,
      Appearance.system => ThemeMode.system,
    },
    routerDelegate: _router,
    routeInformationParser: const TabRouteParser(),
  );
}
