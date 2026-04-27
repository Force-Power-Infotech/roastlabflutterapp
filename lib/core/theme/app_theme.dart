import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const background = Color(0xFF0C0908);
  static const card = Color(0xFF1A1412);
  static const cardSoft = Color(0xFF241B18);
  static const coffee = Color(0xFFBE8F62);
  static const crema = Color(0xFFE7C9A3);
  static const muted = Color(0xFFB8A89A);
  static const success = Color(0xFF76C893);
  static const warning = Color(0xFFF6BD60);
  static const danger = Color(0xFFE76F51);

  static ThemeData get darkTheme {
    final baseText = GoogleFonts.dmSansTextTheme();
    final displayText = GoogleFonts.soraTextTheme(baseText).copyWith(
      displayLarge: GoogleFonts.sora(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.sora(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.sora(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      textTheme: displayText.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      colorScheme: const ColorScheme.dark(
        primary: coffee,
        secondary: crema,
        surface: card,
        error: danger,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.sora(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: coffee, width: 1.2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardSoft.withValues(alpha: 0.82),
        indicatorColor: coffee.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: states.contains(WidgetState.selected) ? crema : muted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? crema : muted,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white.withValues(alpha: 0.06),
        disabledColor: Colors.white.withValues(alpha: 0.04),
        selectedColor: coffee.withValues(alpha: 0.2),
        labelStyle: const TextStyle(color: Colors.white),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: coffee,
          foregroundColor: background,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      useMaterial3: true,
    );
  }

  static BoxDecoration glassCard({Color? tint}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: (tint ?? Colors.white).withValues(alpha: 0.08),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.22),
          blurRadius: 30,
          offset: const Offset(0, 18),
        ),
      ],
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: AppTheme.glassCard(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
