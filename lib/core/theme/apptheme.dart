import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/appcolors.dart';

class Apptheme {
  static ThemeData lightTheme = ThemeData(
    brightness: .light,
    colorScheme: const ColorScheme(
      brightness: .light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.tertiary,
      onError: AppColors.onTertiary,
      surfaceContainer: AppColors.neutral,
      surface: AppColors.neutralMedium,
      onSurface: AppColors.onNeutral,
    ),
    fontFamily: "Inter",
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.neutralMedium,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  );
}
