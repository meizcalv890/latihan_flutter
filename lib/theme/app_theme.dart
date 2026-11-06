import 'package:flutter/material.dart';

class AppTheme {
  // Main identity
  static const Color primary = Color(0xFF172B3A);
  static const Color primaryDark = Color(0xFF10212D);

  // Light surfaces
  static const Color background = Color(0xFFF1EEE6);
  static const Color surface = Color(0xFFFFFEFB);
  static const Color surfaceMuted = Color(0xFFE8E5DC);

  // Typography
  static const Color textPrimary = Color(0xFF202923);
  static const Color textSecondary = Color(0xFF747C73);

  // Borders
  static const Color border = Color(0xFFDDDCD3);

  // Accent colors
  static const Color accent = Color(0xFF9BB7A3);
  static const Color green = Color(0xFF315E49);
  static const Color greenLight = Color(0xFFE2EAE3);

  static const Color blue = Color(0xFF355E78);
  static const Color blueLight = Color(0xFFE5EBEF);

  static const Color warning = Color(0xFFB76E42);
  static const Color danger = Color(0xFFB84C45);

  // Light theme
  static ThemeData get lightTheme {
    const ColorScheme colors = ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      secondary: green,
      onSecondary: Colors.white,
      surface: surface,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      outline: border,
      outlineVariant: Color(0xFFE5E2D9),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF8F6F0),
      surfaceContainer: Color(0xFFF1EEE6),
      surfaceContainerHigh: Color(0xFFECE9E0),
      surfaceContainerHighest: surfaceMuted,
      secondaryContainer: greenLight,
      onSecondaryContainer: Color(0xFF244936),
      error: danger,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colors,
      scaffoldBackgroundColor: background,
      fontFamily: 'Roboto',

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          color: textPrimary,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: border),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        hintStyle: const TextStyle(color: textSecondary),
        labelStyle: const TextStyle(color: textSecondary),
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: border),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      dividerTheme: const DividerThemeData(color: border, thickness: 1),

      iconTheme: const IconThemeData(color: textSecondary),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          height: 1.12,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.5,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          height: 1.2,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(fontSize: 15, height: 1.5, color: textPrimary),
        bodyMedium: TextStyle(fontSize: 13, height: 1.5, color: textSecondary),
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    const Color darkBackground = Color(0xFF101820);
    const Color darkSurface = Color(0xFF1B2832);
    const Color darkText = Color(0xFFE8EEE9);
    const Color darkSecondary = Color(0xFFA5B2AC);
    const Color darkBorder = Color(0xFF354650);
    const Color darkGreen = Color(0xFF8EB99C);

    const ColorScheme colors = ColorScheme.dark(
      primary: darkGreen,
      onPrimary: darkBackground,
      secondary: darkGreen,
      onSecondary: darkBackground,
      surface: darkSurface,
      onSurface: darkText,
      onSurfaceVariant: darkSecondary,
      outline: darkBorder,
      outlineVariant: Color(0xFF2D3D47),
      surfaceContainerLowest: Color(0xFF121D25),
      surfaceContainerLow: Color(0xFF17232C),
      surfaceContainer: darkSurface,
      surfaceContainerHigh: Color(0xFF24343F),
      surfaceContainerHighest: Color(0xFF2B3C47),
      secondaryContainer: Color(0xFF294638),
      onSecondaryContainer: Color(0xFFD0E8D6),
      error: Color(0xFFFF8A80),
      onError: darkBackground,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colors,
      scaffoldBackgroundColor: darkBackground,
      fontFamily: 'Roboto',

      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: darkText,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w800,
          color: darkText,
        ),
        iconTheme: IconThemeData(color: darkText),
      ),

      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: darkBorder),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF24343F),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        hintStyle: const TextStyle(color: darkSecondary),
        labelStyle: const TextStyle(color: darkSecondary),
        prefixIconColor: darkSecondary,
        suffixIconColor: darkSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkGreen, width: 1.5),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkGreen,
          foregroundColor: darkBackground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkText,
          side: const BorderSide(color: darkBorder),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      dividerTheme: const DividerThemeData(color: darkBorder, thickness: 1),

      iconTheme: const IconThemeData(color: darkSecondary),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          height: 1.12,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.5,
          color: darkText,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          height: 1.2,
          fontWeight: FontWeight.w800,
          color: darkText,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: darkText,
        ),
        bodyLarge: TextStyle(fontSize: 15, height: 1.5, color: darkText),
        bodyMedium: TextStyle(fontSize: 13, height: 1.5, color: darkSecondary),
      ),
    );
  }
}
