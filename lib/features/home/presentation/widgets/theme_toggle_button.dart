import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme_mode.dart';
import '../../../../core/theme/presentation/theme_state.dart';
import '../../../../core/theme/presentation/theme_view_model.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeViewModelProvider);

    ref.listen(themeViewModelProvider, (previous, next) {
      if (next case ThemeSaveFailure(:final message)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return IconButton(
      tooltip: 'Alternar tema',
      onPressed: themeState is ThemeSaving
          ? null
          : () => ref.read(themeViewModelProvider.notifier).toggleTheme(),
      icon: Icon(
        themeState.mode == AppThemeMode.dark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
    );
  }
}
