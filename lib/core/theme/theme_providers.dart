import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/storage_providers.dart';
import 'data/theme_repository.dart';
import 'data/theme_service.dart';

final themeServiceProvider = Provider<ThemeService>((ref) {
  return ThemeService(ref.watch(settingsLocalServiceProvider));
});

final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  return LocalThemeRepository(ref.watch(themeServiceProvider));
});
