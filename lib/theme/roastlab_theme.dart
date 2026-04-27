import 'package:flutter/material.dart';

final ThemeData roastLabTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFD39B5B),
    brightness: Brightness.dark,
    primary: const Color(0xFFE7B15E),
    secondary: const Color(0xFFB56B4F),
    surface: const Color(0xFF1A1714),
  ),
  scaffoldBackgroundColor: const Color(0xFF0D0B0A),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: const Color(0xFF15110F).withValues(alpha: 0.92),
    indicatorColor: const Color(0xFFE7B15E).withValues(alpha: 0.16),
    labelTextStyle: MaterialStatePropertyAll(
      TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: Colors.white.withValues(alpha: 0.82),
      ),
    ),
  ),
  textTheme:
      const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
          height: 1.02,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
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
          fontWeight: FontWeight.w500,
          height: 1.35,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          height: 1.35,
        ),
      ).apply(
        bodyColor: Colors.white.withValues(alpha: 0.9),
        displayColor: Colors.white,
      ),
);
