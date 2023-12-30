import 'package:qi_services/common_lib.dart';

/// https://m3.material.io/foundations/layout/applying-layout/window-size-classes
/// https://developer.android.com/guide/topics/large-screens/support-different-screen-sizes#window_size_classes
enum Responsive {
  /// Phone in portrait
  /// https://m3.material.io/foundations/layout/applying-layout/compact
  compact(min: 0, max: 599),

  /// Tablet in portrait
  /// Foldable in portrait (unfolded)
  /// https://m3.material.io/foundations/layout/applying-layout/medium
  medium(min: 600, max: 839),

  /// Phone in landscape
  /// Tablet in landscape
  /// Foldable in landscape (unfolded)
  /// Desktop
  /// https://m3.material.io/foundations/layout/applying-layout/expanded
  expanded(min: 840, max: double.infinity);

  const Responsive({required this.min, required this.max});

  /// The minimum width of the screen
  final double min;

  /// The maximum width of the screen
  final double max;

  factory Responsive.fromSize(Size size) {
    final width = size.width;

    if (width >= expanded.min) {
      return expanded;
    } else if (width >= medium.min) {
      return medium;
    } else {
      return compact;
    }
  }

  static R when<R>({
    required BuildContext context,
    required ResponsiveBuilder<R> compact,
    required ResponsiveBuilder<R> medium,
    required ResponsiveBuilder<R> expanded,
  }) {
    final type = Responsive.fromSize(MediaQuery.sizeOf(context));

    return switch (type) {
      Responsive.compact => compact(),
      Responsive.medium => medium(),
      Responsive.expanded => expanded(),
    };
  }

  static R maybeWhen<R>({
    required BuildContext context,
    ResponsiveBuilder<R>? compact,
    ResponsiveBuilder<R>? medium,
    ResponsiveBuilder<R>? expanded,
    required ResponsiveBuilder<R> orElse,
  }) {
    final type = Responsive.fromSize(MediaQuery.sizeOf(context));

    return switch (type) {
      Responsive.compact => compact?.call() ?? orElse(),
      Responsive.medium => medium?.call() ?? orElse(),
      Responsive.expanded => expanded?.call() ?? orElse(),
    };
  }
}

typedef ResponsiveBuilder<R> = R Function();
