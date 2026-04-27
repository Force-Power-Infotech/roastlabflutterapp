import 'package:flutter/material.dart';

final ThemeData roastLabTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2A9D8F),
    brightness: Brightness.light,
    primary: const Color(0xFF2A9D8F),
    secondary: const Color(0xFFF4A261),
    surface: const Color(0xFFFFFBF5),
  ),
  scaffoldBackgroundColor: const Color(0xFFF7F3EC),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: const Color(0xFFFFFCF8),
    indicatorColor: const Color(0xFF2A9D8F).withValues(alpha: 0.14),
    labelTextStyle: MaterialStatePropertyAll(
      TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: Colors.black.withValues(alpha: 0.78),
      ),
    ),
    elevation: 8,
    shadowColor: const Color(0x33000000),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF2A9D8F),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFFFFFCF8),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  ),
  textTheme:
      const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
          height: 1.02,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.6,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          height: 1.35,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          height: 1.35,
        ),
      ).apply(
        bodyColor: const Color(0xFF1D1A17),
        displayColor: const Color(0xFF0E0C0A),
      ),
);
