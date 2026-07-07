import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'hive_boxes.dart';

final settingsBoxProvider = Provider<Box>((ref) {
  return Hive.box(HiveBoxes.settings);
});

final authBoxProvider = Provider<Box>((ref) {
  return Hive.box(HiveBoxes.auth);
});

final playersBoxProvider = Provider<Box>((ref) {
  return Hive.box(HiveBoxes.players);
});

final appVersionBoxProvider = Provider<Box>((ref) {
  return Hive.box(HiveBoxes.appVersion);
});