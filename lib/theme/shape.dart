import 'responsive.dart';

/// Implementation of shape M3 and spacing read more at:
/// https://m3.material.io/styles/shape/overview
/// and at flutter docs Single source of truth for styling
/// https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps#single-source-of-truth-for-styling
abstract final class Insets {
  static const double none = 0.0;

  static const double xsmall = 4.0;

  static const double small = 8.0;

  /// default [ResponsiveSize.compact] spacing horizontal
  static const double medium = 16.0;

  /// default [ResponsiveSize.medium], [ResponsiveSize.expanded] spacing horizontal
  static const double large = 24.0;

  static const double extraLarge = 48.0;

  static const double rounded = 100.0;
}

abstract final class Radiuses {
  static const double none = 0.0;

  static const double xsmall = 4.0;

  static const double small = 8.0;

  static const double medium = 16.0;

  static const double large = 24.0;

  static const double extraLarge = 48.0;

  static const double rounded = 100.0;
}

// https://m3.material.io/foundations/accessible-design/accessibility-basics#497996ce-d1f3-4c42-abf2-c6dd1f57d371
abstract final class IconSizes {
  static const double none = 0.0;

  static const double small = 16.0;

  static const double medium = 24.0;

  static const double large = 36.0;

  static const double extraLarge = 48.0;
}

abstract final class StrokeWidths {
  static const double none = 0.0;

  static const double xsmall = 1.0;

  static const double small = 2.0;

  static const double medium = 4.0;

  static const double large = 8.0;

  static const double extraLarge = 16.0;
}
