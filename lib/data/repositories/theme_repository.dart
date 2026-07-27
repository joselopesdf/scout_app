import '../../domain/models/app_theme_mode.dart';
import '../services/theme_service.dart';

abstract interface class ThemeRepository {
  AppThemeMode readThemeMode();

  Future<void> saveThemeMode(AppThemeMode mode);
}

class LocalThemeRepository implements ThemeRepository {
  LocalThemeRepository(this._service);

  final ThemeService _service;

  @override
  AppThemeMode readThemeMode() => _service.read();

  @override
  Future<void> saveThemeMode(AppThemeMode mode) {
    return _service.save(mode);
  }
}
