import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  // Light Mode Colors (with 100% Opacity)
  static const Color primary =
      Color.fromRGBO(26, 35, 126, 0.75); // Deep Navy Blue
  static const Color secondary =
      Color.fromRGBO(255, 111, 0, 1.0); // Dark Orange
  static const Color accent = Color.fromRGBO(0, 137, 123, 1.0); // Teal Green
  static const Color background =
      Color.fromRGBO(245, 245, 245, 1.0); // Light Gray
  static const Color cardBackground =
      Color.fromRGBO(255, 255, 255, 1.0); // White
  static const Color text = Color.fromRGBO(33, 33, 33, 1.0); // Dark Gray
  static const Color subtext = Color.fromRGBO(117, 117, 117, 1.0); // Muted Gray
  static const Color mainText =
      Color.fromRGBO(52, 73, 94, 1.0); // Main text color
  static const Color titleText =
      Color.fromRGBO(0, 0, 0, 1.0); // Main text color

  // Dark Mode Colors
  static const Color darkPrimary =
      Color.fromRGBO(57, 73, 171, 0.75); // Brighter Navy Blue
  static const Color darkSecondary =
      Color.fromRGBO(255, 145, 0, 1.0); // Bright Orange
  static const Color darkAccent =
      Color.fromRGBO(38, 166, 154, 1.0); // Lighter Teal
  static const Color darkBackground =
      Color.fromRGBO(18, 18, 18, 1.0); // Dark Gray
  static const Color darkCardBackground =
      Color.fromRGBO(28, 28, 28, 1); // Slightly Lighter Gray
  static const Color darkText =
      Color.fromRGBO(224, 224, 224, 1.0); // Light Gray
  static const Color darkSubtext =
      Color.fromRGBO(158, 158, 158, 1.0); // Muted Gray
  static const Color darkMainText =
      Color.fromRGBO(245, 245, 245, 1.0); // Main text color
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.secondary,
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: AppColors.cardBackground,
    dialogTheme: const DialogTheme(
      backgroundColor:
          AppColors.cardBackground, // Light theme dialog background
      titleTextStyle: TextStyle(
        color: AppColors.mainText,
      ),
      iconColor: AppColors.accent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor:
          AppColors.cardBackground, // Light theme app bar background
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.mainText),
      bodyMedium: TextStyle(color: AppColors.subtext),
      titleLarge: TextStyle(color: AppColors.titleText),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardBackground, // Light theme background
      selectedItemColor: AppColors.accent, // Selected item color
      unselectedItemColor: AppColors.subtext, // Unselected item color
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    secondaryHeaderColor: AppColors.darkSecondary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    dividerColor: AppColors.darkCardBackground,
    dialogTheme: const DialogTheme(
      backgroundColor:
          AppColors.darkCardBackground, // Dark theme dialog background
      titleTextStyle: TextStyle(
        color: AppColors.darkText,
      ),
      iconColor: AppColors.accent,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor:
          AppColors.darkCardBackground, // Dark theme app bar background
      iconTheme: const IconThemeData(color: AppColors.darkAccent), // Icon color
      titleTextStyle: const TextStyle(
        color: AppColors.darkText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkMainText),
      bodyMedium: TextStyle(color: AppColors.darkSubtext),
      titleLarge: TextStyle(color: AppColors.darkMainText),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkCardBackground, // Dark theme background
      selectedItemColor: AppColors.darkAccent, // Selected item color
      unselectedItemColor: AppColors.darkText, // Unselected item color
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  static const String _themeKey = 'isDarkMode';

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme =>
      _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    _saveTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
  }
}
