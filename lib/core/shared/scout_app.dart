import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routing/app_router.dart';
import '../theme/presentation/app_theme.dart';
import '../theme/presentation/theme_view_model.dart';

class ScoutApp extends ConsumerWidget {
  const ScoutApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeState = ref.watch(themeViewModelProvider);

    return MaterialApp.router(
      title: 'Scout App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: AppTheme.toFlutterThemeMode(themeState.mode),
      routerConfig: router,
    );
  }
}
