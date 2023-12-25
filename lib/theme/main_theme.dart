import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTheme {
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

  ThemeData buildDark() {
    return _build(
      scaffoldBackgroundColor: const Color(0xff000000),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff17B6A4),
        onPrimary: Colors.white,
        secondary: Color(0xffF4C300),
        onSecondary: Colors.black,
        surface: Color(0xff282828),
        onSurface: Colors.white,
        surfaceVariant: Color(0xff2D2D2D),
        onSurfaceVariant: Color(0xffA0A0A0),
        background: Color(0xff000000),
        onBackground: Colors.white,
        error: Color(0xffF44336),
        onError: Colors.white,
      ),
    );
  }

  ThemeData _build({
    required Color scaffoldBackgroundColor,
    required ColorScheme colorScheme,
  }) {
    ThemeData theme = ThemeData(
      useMaterial3: false,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
    );

    theme = theme.copyWith(textTheme: _buildTextTheme(theme));

    return theme = theme.copyWith(
      appBarTheme: _buildAppBarTheme(theme),
      inputDecorationTheme: _buildInputDecorationTheme(theme),
      filledButtonTheme: _buildFilledButtonTheme(theme),
    );
  }

  TextTheme _buildTextTheme(ThemeData theme) {
    /// Fix [GoogleFonts.cairoTextTheme] height issue
    final textStyle = TextStyle(
      height: 1.5,
      color: theme.colorScheme.onBackground,
    );
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

  InputDecorationTheme _buildInputDecorationTheme(ThemeData theme) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  FilledButtonThemeData _buildFilledButtonTheme(ThemeData theme) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: theme.textTheme.titleMedium,
        padding: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }

  AppBarTheme _buildAppBarTheme(ThemeData theme) {
    return AppBarTheme(
      elevation: 0.0,
      backgroundColor: theme.scaffoldBackgroundColor,
      foregroundColor: theme.colorScheme.primary,
      iconTheme: IconThemeData(color: theme.colorScheme.onBackground),
    );
  }
}
