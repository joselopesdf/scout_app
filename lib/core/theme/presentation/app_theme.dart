import 'package:flutter/material.dart';

import '../app_theme_mode.dart';
import 'scout_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() {
    return _build(Brightness.light);
  }

  static ThemeData dark() {
    return _build(Brightness.dark);
  }

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final primary = isDark ? ScoutColors.darkGreen : ScoutColors.navy;
    final background = isDark
        ? ScoutColors.darkBackground
        : ScoutColors.background;
    final surface = isDark ? ScoutColors.darkSurface : ScoutColors.surface;
    final textPrimary = isDark
        ? ScoutColors.darkTextPrimary
        : ScoutColors.textPrimary;
    final textSecondary = isDark
        ? ScoutColors.darkTextSecondary
        : ScoutColors.textSecondary;

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: ScoutColors.navy,
          brightness: brightness,
        ).copyWith(
          primary: primary,
          onPrimary: isDark ? ScoutColors.navy : Colors.white,
          secondary: isDark ? ScoutColors.darkGreen : ScoutColors.green,
          onSecondary: ScoutColors.navy,
          surface: surface,
          onSurface: textPrimary,
          error: ScoutColors.error,
          onError: Colors.white,
        );

    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
    );

    final textTheme = baseTheme.textTheme.copyWith(
      displaySmall: baseTheme.textTheme.displaySmall?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.w800,
        height: 1.1,
      ),
      headlineMedium: baseTheme.textTheme.headlineMedium?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      titleLarge: baseTheme.textTheme.titleLarge?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: baseTheme.textTheme.titleMedium?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(
        color: textPrimary,
        height: 1.5,
      ),
      bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
        color: textSecondary,
        height: 1.5,
      ),
      labelLarge: baseTheme.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(ScoutRadii.small),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    );

    return baseTheme.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: background,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScoutRadii.medium),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 52),
          padding: const EdgeInsets.symmetric(
            horizontal: ScoutSpacing.lg,
            vertical: ScoutSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScoutRadii.small),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 52),
          padding: const EdgeInsets.symmetric(
            horizontal: ScoutSpacing.lg,
            vertical: ScoutSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScoutRadii.small),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(minimumSize: const Size.square(48)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: ScoutSpacing.md,
          vertical: ScoutSpacing.md,
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        space: ScoutSpacing.lg,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScoutRadii.small),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.secondary,
      ),
    );
  }

  static ThemeMode toFlutterThemeMode(AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.system => ThemeMode.system,
      AppThemeMode.light => ThemeMode.light,
      AppThemeMode.dark => ThemeMode.dark,
    };
  }
}
