import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qi_services/theme/color_schemes.dart';

class MainTheme {
  ThemeData buildLight() {
    return _build(colorScheme: lightColorScheme);
  }

  ThemeData buildDark() {
    return _build(colorScheme: darkColorScheme);
  }

  ThemeData _build({required ColorScheme colorScheme}) {
    ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
    );

    theme = theme.copyWith(textTheme: _buildTextTheme(theme));

    return theme = theme.copyWith(
      inputDecorationTheme: _buildInputDecorationTheme(theme),
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
    return const InputDecorationTheme(
      border: OutlineInputBorder(),
    );
  }
}
