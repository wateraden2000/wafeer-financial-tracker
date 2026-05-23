import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color darkBackground = Color(0xFF0C0B14);
  static const Color darkCard = Color(0xFF161426);
  static const Color darkGlass = Color(0x1Fffffff);
  
  static const Color primary = Color(0xFF7B2CBF);
  static const Color primaryLight = Color(0xFF9D4EDD);
  static const Color primaryAccent = Color(0xFFE0AAFF);
  
  static const Color income = Color(0xFF00F5D4);
  static const Color expense = Color(0xFFFF006E);
  static const Color budgetWarning = Color(0xFFFFBE0B);
  
  static const Color textPrimaryDark = Color(0xFFF8F9FA);
  static const Color textSecondaryDark = Color(0xFFADB5BD);

  // Modern Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: primaryLight,
        surface: darkCard,
        background: darkBackground,
        error: expense,
      ),
      fontFamily: 'Outfit',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimaryDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardTheme(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0x1AFFFFFF), width: 1),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: darkCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: const BorderSide(color: Color(0x1AFFFFFF), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x0AFFFFFF),
        labelStyle: const TextStyle(color: textSecondaryDark),
        hintStyle: const TextStyle(color: Color(0xFF6C757D)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0x1AFFFFFF), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0x1AFFFFFF), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
      ),
    );
  }
}
