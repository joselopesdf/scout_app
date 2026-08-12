import '../app_theme_mode.dart';

sealed class ThemeState {
  const ThemeState(this.mode);

  final AppThemeMode mode;
}

final class ThemeLoaded extends ThemeState {
  const ThemeLoaded(super.mode);
}

final class ThemeSaving extends ThemeState {
  const ThemeSaving(super.mode);
}

final class ThemeSaveFailure extends ThemeState {
  const ThemeSaveFailure({required AppThemeMode mode, required this.message})
    : super(mode);

  final String message;
}
