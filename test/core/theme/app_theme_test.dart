import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scout_app/core/theme/presentation/app_theme.dart';
import 'package:scout_app/core/theme/presentation/scout_tokens.dart';

void main() {
  group('AppTheme', () {
    test('light theme uses the Scout visual identity', () {
      final theme = AppTheme.light();

      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, ScoutColors.navy);
      expect(theme.colorScheme.secondary, ScoutColors.green);
      expect(theme.scaffoldBackgroundColor, ScoutColors.background);
      expect(theme.colorScheme.error, ScoutColors.error);
    });

    test('interactive controls meet the minimum height', () {
      final buttonSize = AppTheme.light().filledButtonTheme.style?.minimumSize
          ?.resolve({});

      expect(buttonSize?.height, greaterThanOrEqualTo(48));
    });

    test('dark theme keeps a distinct accessible surface hierarchy', () {
      final theme = AppTheme.dark();

      expect(theme.brightness, Brightness.dark);
      expect(theme.scaffoldBackgroundColor, ScoutColors.darkBackground);
      expect(theme.colorScheme.surface, ScoutColors.darkSurface);
      expect(theme.colorScheme.primary, ScoutColors.darkGreen);
    });
  });
}
