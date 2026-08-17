import 'package:hive/hive.dart';

class SettingsLocalService {
  SettingsLocalService(this._box);

  static const settingsBoxName = 'settings';

  final Box<Object?> _box;

  bool? readBool(String key) => _box.get(key) as bool?;

  String? readString(String key) => _box.get(key) as String?;

  Future<void> writeBool(String key, bool value) => _box.put(key, value);

  Future<void> writeString(String key, String value) => _box.put(key, value);
}
