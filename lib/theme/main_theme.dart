import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qi_services/theme/color_schemes.dart';

class MainTheme {
  const MainTheme({
    required this.localeName,
  });

  final String localeName;

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
    switch (localeName) {
      case 'ar':
        return GoogleFonts.cairoTextTheme(theme.textTheme);
      default:
        return GoogleFonts.montserratTextTheme(theme.textTheme);
    }
  }

  InputDecorationTheme _buildInputDecorationTheme(ThemeData theme) {
    return const InputDecorationTheme(
      border: OutlineInputBorder(),
    );
  }
}
