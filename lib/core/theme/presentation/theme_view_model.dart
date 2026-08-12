import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme_mode.dart';
import '../data/theme_repository.dart';
import '../theme_providers.dart';
import 'theme_state.dart';

final themeViewModelProvider = NotifierProvider<ThemeViewModel, ThemeState>(
  ThemeViewModel.new,
);

class ThemeViewModel extends Notifier<ThemeState> {
  late ThemeRepository _repository;

  @override
  ThemeState build() {
    _repository = ref.watch(themeRepositoryProvider);
    return ThemeLoaded(_repository.readThemeMode());
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    if (state is ThemeSaving || mode == state.mode) return;

    final previousMode = state.mode;
    state = ThemeSaving(mode);

    try {
      await _repository.saveThemeMode(mode);
      state = ThemeLoaded(mode);
    } catch (_) {
      state = ThemeSaveFailure(
        mode: previousMode,
        message: 'Não foi possível guardar o tema.',
      );
    }
  }

  Future<void> toggleTheme() {
    return setThemeMode(
      state.mode == AppThemeMode.dark ? AppThemeMode.light : AppThemeMode.dark,
    );
  }
}
