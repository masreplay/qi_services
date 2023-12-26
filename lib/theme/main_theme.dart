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
      listTileTheme: ListTileThemeData(
        iconColor: theme.colorScheme.primary,
      ),
    );
  }

  TextTheme _buildTextTheme(ThemeData theme) {
    return GoogleFonts.cairoTextTheme(theme.textTheme);
  }

  InputDecorationTheme _buildInputDecorationTheme(ThemeData theme) {
    return const InputDecorationTheme(
      border: OutlineInputBorder(),
    );
  }
}
