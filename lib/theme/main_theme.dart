import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///
class MainTheme {
  ThemeData _build({required ColorScheme colorScheme}) {
    final theme = ThemeData(
      useMaterial3: false,
      colorScheme: colorScheme,
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme),
      filledButtonTheme: _buildFilledButtonTheme(colorScheme),
    );

    // Copy with theme to get the updated theme with color scheme
    return theme.copyWith(
      textTheme: GoogleFonts.cairoTextTheme(theme.textTheme),
    );
  }

  ThemeData buildLight() {
    return _build(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff17B6A4),
        onPrimary: Colors.white,
        secondary: Color(0xffF4C300),
        onSecondary: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
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
