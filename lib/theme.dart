import 'package:flutter/material.dart';

class MainTheme {
  ThemeData _build(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData buildLight() => _build(const ColorScheme.light());
}
