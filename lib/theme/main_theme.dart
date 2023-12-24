import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///
class MainTheme {
  ThemeData _build({
    required Color scaffoldBackgroundColor,
    required ColorScheme colorScheme,
  }) {
    ThemeData theme = ThemeData(
      useMaterial3: false,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme),
      filledButtonTheme: _buildFilledButtonTheme(colorScheme),
    );

    // Copy with theme to get the updated theme with color scheme

    return theme = theme.copyWith(
      textTheme: _buildTextTheme(colorScheme),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
      ),
    );
  }

  TextTheme _buildTextTheme(ColorScheme colorScheme) {
    /// Fix [GoogleFonts.cairoTextTheme] height issue
    final textStyle = TextStyle(height: 1.5, color: colorScheme.onBackground);
    final textTheme = TextTheme(
      displayLarge: textStyle,
      displayMedium: textStyle,
      displaySmall: textStyle,
      headlineLarge: textStyle,
      headlineMedium: textStyle,
      headlineSmall: textStyle,
      titleLarge: textStyle,
      titleMedium: textStyle,
      titleSmall: textStyle,
      bodyLarge: textStyle,
      bodyMedium: textStyle,
      bodySmall: textStyle,
      labelLarge: textStyle,
      labelMedium: textStyle,
      labelSmall: textStyle,
    );
    return GoogleFonts.cairoTextTheme(textTheme);
  }

  ThemeData buildLight() {
    return _build(
      scaffoldBackgroundColor: const Color(0xffF7F8FC),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff17B6A4),
        onPrimary: Colors.white,
        secondary: Color(0xffF4C300),
        onSecondary: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
        surfaceVariant: Color(0xffEDF4FC),
        onSurfaceVariant: Color(0xffA0A0A0),
        background: Colors.white,
        onBackground: Colors.black,
        error: Color(0xffF44336),
        onError: Colors.white,
      ),
    );
  }

  InputDecorationTheme _buildInputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  FilledButtonThemeData _buildFilledButtonTheme(ColorScheme colorScheme) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        // elevation: 2.0,
        textStyle: const TextStyle(fontSize: 14.0),
        padding: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }

  ThemeData buildDark() => buildLight();
}
