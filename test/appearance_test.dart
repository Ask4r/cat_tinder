import 'package:cat_tinder/state/appearance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'rapid theme changes persist the final choice and restore on restart',
    () async {
      final original = SharedPreferencesAsyncPlatform.instance;
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      addTearDown(() => SharedPreferencesAsyncPlatform.instance = original);
      Future<SharedPreferencesWithCache> open() =>
          SharedPreferencesWithCache.create(
            cacheOptions: const SharedPreferencesWithCacheOptions(
              allowList: {AppearancePreferences.storageKey},
            ),
          );
      final preferences = await open();
      final session = ProviderContainer(
        overrides: [
          appearanceProvider.overrideWith(
            () => AppearancePreferences(preferences: preferences),
          ),
        ],
      );
      expect(session.read(appearanceProvider), Appearance.system);
      final controller = session.read(appearanceProvider.notifier);
      final first = controller.select(Appearance.dark);
      final last = controller.select(Appearance.light);
      expect(session.read(appearanceProvider), Appearance.light);
      await Future.wait([first, last]);
      session.dispose();

      final restored = await open();
      final nextSession = ProviderContainer(
        overrides: [
          appearanceProvider.overrideWith(
            () => AppearancePreferences(preferences: restored),
          ),
        ],
      );
      expect(nextSession.read(appearanceProvider), Appearance.light);
      await nextSession
          .read(appearanceProvider.notifier)
          .select(Appearance.system);
      nextSession.dispose();
      final systemPreferences = await open();
      final systemSession = ProviderContainer(
        overrides: [
          appearanceProvider.overrideWith(
            () => AppearancePreferences(preferences: systemPreferences),
          ),
        ],
      );
      addTearDown(systemSession.dispose);
      expect(systemSession.read(appearanceProvider), Appearance.system);
    },
  );
}
