import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'settings_local_service.dart';

final settingsBoxProvider = Provider<Box<Object?>>((ref) {
  return Hive.box<Object?>(SettingsLocalService.settingsBoxName);
});

final settingsLocalServiceProvider = Provider<SettingsLocalService>((ref) {
  return SettingsLocalService(ref.watch(settingsBoxProvider));
});
