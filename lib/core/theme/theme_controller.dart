import 'package:flutter/material.dart';

import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

import '../local_storage/hive_keys.dart';
import '../local_storage/hive_providers.dart';

final themeModeProvider =
StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final settingsBox = ref.watch(settingsBoxProvider);
  return ThemeModeNotifier(settingsBox);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier(this._settingsBox) : super(_loadThemeMode(_settingsBox));

  final Box _settingsBox;

  static ThemeMode _loadThemeMode(Box box) {
    final savedValue = box.get(HiveKeys.themeMode) as String?;

    switch (savedValue) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;

    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

    await _settingsBox.put(HiveKeys.themeMode, value);
  }

  Future<void> toggleTheme() async {
    if (state == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      await setThemeMode(ThemeMode.dark);
    }
  }
}