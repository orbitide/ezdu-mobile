import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFF818CF8); // Light Indigo
  static const Color primaryDark = Color(0xFF4F46E5); // Dark Indigo

  // Secondary Colors
  static const Color secondary = Color(0xFF10B981); // Emerald
  static const Color secondaryLight = Color(0xFF34D399); // Light Emerald
  static const Color secondaryDark = Color(0xFF059669); // Dark Emerald

  // Accent Colors
  static const Color accent = Color(0xFFF59E0B); // Amber
  static const Color accentLight = Color(0xFFFBBF24); // Light Amber
  static const Color accentDark = Color(0xFFD97706); // Dark Amber

  // Success, Warning, Error
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red

  // Neutral Colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  static ThemeData get lightTheme {
    final ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primaryLight,
      onPrimaryContainer: primaryDark,
      secondary: secondary,
      onSecondary: Colors.white,
      secondaryContainer: secondaryLight,
      onSecondaryContainer: secondaryDark,
      tertiary: accent,
      onTertiary: Colors.white,
      tertiaryContainer: accentLight,
      onTertiaryContainer: accentDark,
      error: error,
      onError: Colors.white,
      errorContainer: const Color(0xFFFFEBEE),
      onErrorContainer: const Color(0xFFC62828),
      surface: Colors.white,
      onSurface: neutral900,
      surfaceContainerHighest: neutral50,
      outline: neutral300,
      outlineVariant: neutral200,
      background: neutral50,
      onBackground: neutral900,
      scrim: Colors.black,
      surfaceTint: primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      scaffoldBackgroundColor: lightColorScheme.background,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: lightColorScheme.surface,
        foregroundColor: lightColorScheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(
        lightColorScheme.primary,
        lightColorScheme.onPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: neutral100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: neutral300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: neutral300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary, width: 2),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primary,
        unselectedItemColor: neutral400,
      ),
    );
  }

  static ThemeData get darkTheme {
    final ColorScheme darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primaryLight,
      onPrimary: primaryDark,
      primaryContainer: primaryDark,
      onPrimaryContainer: primaryLight,
      secondary: secondaryLight,
      onSecondary: secondaryDark,
      secondaryContainer: secondaryDark,
      onSecondaryContainer: secondaryLight,
      tertiary: accentLight,
      onTertiary: accentDark,
      tertiaryContainer: accentDark,
      onTertiaryContainer: accentLight,
      error: const Color(0xFFFF6B6B),
      onError: error,
      errorContainer: const Color(0xFF5F0F0C),
      onErrorContainer: const Color(0xFFFF6B6B),
      surface: const Color(0xFF191919),
      onSurface: neutral50,
      surfaceContainerHighest: neutral800,
      outline: neutral600,
      outlineVariant: neutral700,
      scrim: Colors.black87,
      surfaceTint: primaryLight,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: darkColorScheme.surface,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: darkColorScheme.surface,
        foregroundColor: darkColorScheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(
        darkColorScheme.onPrimary,
        neutral50,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: neutral800,
        hintStyle: TextStyle(color: neutral400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: neutral700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: neutral700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryLight, width: 2),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: neutral900,
        selectedItemColor: primaryLight,
        unselectedItemColor: neutral600,
      ),
    );
  }
}

ElevatedButtonThemeData _buildElevatedButtonTheme(
    Color primaryColor,
    Color onPrimaryColor,
    ) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: onPrimaryColor,
      elevation: 2,
      shadowColor: primaryColor.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
    ),
  );
}

