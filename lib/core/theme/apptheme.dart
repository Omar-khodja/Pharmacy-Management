import 'package:flutter/material.dart';
import 'package:pharmacy_management/core/theme/appcolors.dart';

class Apptheme {
  static ThemeData lightTheme = ThemeData(
    brightness: .light,
    colorScheme: ColorScheme(
      brightness: .light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.tertiary,
      onError: AppColors.onTertiary,
      surface: AppColors.neutral,
      onSurface: AppColors.onNeutral,
    ),
    fontFamily: "Inter",
    useMaterial3: true,
     textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  );
}
