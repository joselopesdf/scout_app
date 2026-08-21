import 'package:flutter/material.dart';

abstract final class ScoutColors {
  static const navy = Color(0xFF0F172A);
  static const green = Color(0xFF16A34A);
  static const background = Color(0xFFF8FAFC);
  static const surface = Colors.white;
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF64748B);
  static const error = Color(0xFFDC2626);

  static const darkBackground = Color(0xFF020617);
  static const darkSurface = Color(0xFF0F172A);
  static const darkTextPrimary = Color(0xFFF8FAFC);
  static const darkTextSecondary = Color(0xFF94A3B8);
  static const darkGreen = Color(0xFF4ADE80);
}

abstract final class ScoutSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

abstract final class ScoutRadii {
  static const small = 12.0;
  static const medium = 16.0;
}

abstract final class ScoutDurations {
  static const fast = Duration(milliseconds: 150);
  static const standard = Duration(milliseconds: 200);
  static const slow = Duration(milliseconds: 250);
}
