import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/debug/riverpod_logger.dart';
import 'core/local_storage/hive_boxes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  await Hive.openBox(HiveBoxes.settings);
  await Hive.openBox(HiveBoxes.auth);
  await Hive.openBox(HiveBoxes.players);
  await Hive.openBox(HiveBoxes.appVersion);


  runApp(
    const ProviderScope(
      observers: [
        RiverpodLogger(),
      ],
      child: ScoutApp(),
    ),
  );
}