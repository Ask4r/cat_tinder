import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Appearance { light, dark, system }

final appearanceProvider = NotifierProvider<AppearancePreferences, Appearance>(
  AppearancePreferences.new,
);

class AppearancePreferences extends Notifier<Appearance> {
  AppearancePreferences({this.preferences});

  static const storageKey = 'appearance';
  final SharedPreferencesWithCache? preferences;
  Future<void> _pendingSave = Future.value();

  @override
  Appearance build() {
    final saved = preferences?.getString(storageKey);
    return Appearance.values
            .where((value) => value.name == saved)
            .firstOrNull ??
        Appearance.system;
  }

  Future<void> select(Appearance appearance) {
    state = appearance;
    // Serialize writes so rapid selections also retain the final choice on disk.
    _pendingSave = _pendingSave.then((_) async {
      try {
        await preferences?.setString(storageKey, appearance.name);
      } catch (error, stack) {
        log(
          'Could not save appearance preference',
          error: error,
          stackTrace: stack,
        );
      }
    });
    return _pendingSave;
  }
}
