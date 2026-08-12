import '../../storage/settings_local_service.dart';
import '../app_theme_mode.dart';

class ThemeService {
  ThemeService(this._storage);

  static const _themeModeKey = 'theme_mode';

  final SettingsLocalService _storage;

  AppThemeMode read() {
    return switch (_storage.readString(_themeModeKey)) {
      'light' => AppThemeMode.light,
      'dark' => AppThemeMode.dark,
      _ => AppThemeMode.system,
    };
  }

  Future<void> save(AppThemeMode mode) {
    final value = switch (mode) {
      AppThemeMode.light => 'light',
      AppThemeMode.dark => 'dark',
      AppThemeMode.system => 'system',
    };

    return _storage.writeString(_themeModeKey, value);
  }
}
