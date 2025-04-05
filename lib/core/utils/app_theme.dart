import 'package:flutter/material.dart';
import 'package:my_resume/core/utils/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.secondary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.text),
      bodyMedium: TextStyle(color: AppColors.subtext),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.secondary, // Light theme background
      selectedItemColor: AppColors.accent, // Selected item color
      unselectedItemColor: AppColors.subtext, // Unselected item color
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    secondaryHeaderColor: AppColors.darkSecondary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkSubtext),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSecondary, // Dark theme background
      selectedItemColor: AppColors.darkAccent, // Selected item color
      unselectedItemColor: AppColors.darkText, // Unselected item color
    ),
  );
}
