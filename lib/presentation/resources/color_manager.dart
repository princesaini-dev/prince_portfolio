import 'package:flutter/material.dart';

class ColorManager {
  static const Color primaryBlack = Color(0xFF0A0A0A);
  static const Color primaryWhite = Color(0xFFFAFAFA);
  static const Color grey = Color(0xFF1A1A2E);
  static const Color darkGrey = Color(0xFF16213E);
  static const Color surfaceDark = Color(0xFF0F0F23);
  static const Color surfaceLight = Color(0xFFF8F9FA);

  static const Color accentPrimary = Color(0xFF6C63FF);
  static const Color accentSecondary = Color(0xFF00D9FF);
  static const Color accentGradientStart = Color(0xFF667EEA);
  static const Color accentGradientEnd = Color(0xFF764BA2);
  static const Color accentPink = Color(0xFFFF6B9D);
  static const Color accentOrange = Color(0xFFFF8C42);
  static const Color accentGreen = Color(0xFF00E676);

  static const Color cardDark = Color(0xFF1E1E30);
  static const Color cardLight = Color(0xFFFFFFFF);

  static Color blackColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? primaryWhite
        : primaryBlack;
  }

  static Color whiteColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surfaceDark
        : surfaceLight;
  }

  static Color greyColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkGrey
        : surfaceLight;
  }

  static Color cardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? cardDark
        : cardLight;
  }

  static Color accentColor(BuildContext context) {
    return accentPrimary;
  }

  static Color redColor(BuildContext context) {
    return accentPrimary;
  }

  static LinearGradient primaryGradient(BuildContext context) {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [accentGradientStart, accentGradientEnd],
    );
  }

  static LinearGradient accentGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [accentPrimary, accentSecondary],
    );
  }

  static LinearGradient backgroundGradient(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isDark
          ? [surfaceDark, const Color(0xFF0D0D1A)]
          : [surfaceLight, const Color(0xFFE8E8F0)],
    );
  }

  static List<BoxShadow> cardShadow(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: isDark
            ? Colors.black.withOpacity(0.3)
            : Colors.black.withOpacity(0.08),
        blurRadius: 20,
        offset: const Offset(0, 8),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: accentPrimary.withOpacity(isDark ? 0.1 : 0.05),
        blurRadius: 40,
        offset: const Offset(0, 4),
        spreadRadius: -10,
      ),
    ];
  }

  static List<BoxShadow> glowShadow(BuildContext context) {
    return [
      BoxShadow(
        color: accentPrimary.withOpacity(0.4),
        blurRadius: 20,
        spreadRadius: 0,
      ),
    ];
  }
}
