import 'package:qi_services/common_lib.dart';

/// https://m3.material.io/foundations/layout/applying-layout/window-size-classes
/// https://developer.android.com/guide/topics/large-screens/support-different-screen-sizes#window_size_classes
enum ResponsiveSize {
  /// Phone in portrait
  compact(0, 599),

  /// Tablet in portrait
  /// Foldable in portrait (unfolded)
  medium(600, 839),

  /// Phone in landscape
  /// Tablet in landscape
  /// Foldable in landscape (unfolded)
  /// Desktop
  expanded(840, double.infinity);

  const ResponsiveSize(this.min, this.max);

  /// The minimum width of the screen
  final double min;

  /// The maximum width of the screen
  final double max;

  factory ResponsiveSize.fromConstraints(BoxConstraints constraints) {
    final width = constraints.maxWidth;

    if (width < medium.max) {
      return compact;
    } else if (width < expanded.max) {
      return medium;
    } else {
      return expanded;
    }
  }
}

typedef ResponsiveWidgetBuilder = Widget Function(
  BuildContext context,
  BoxConstraints constraints,
);

/// No need to prevent unnecessary rebuilds because it's already implemented in [LayoutBuilder]
class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder.when({
    super.key,
    required ResponsiveWidgetBuilder this.compact,
    required ResponsiveWidgetBuilder this.medium,
    required ResponsiveWidgetBuilder this.expanded,
  }) : orElse = null;

  const ResponsiveLayoutBuilder.orElse({
    super.key,
    required ResponsiveWidgetBuilder this.orElse,
    this.compact,
    this.medium,
    this.expanded,
  });

  final ResponsiveWidgetBuilder? compact;
  final ResponsiveWidgetBuilder? medium;
  final ResponsiveWidgetBuilder? expanded;
  final ResponsiveWidgetBuilder? orElse;

  @override
  Widget build(BuildContext context) {
    const Widget defaultWidget = SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final orElse = this.orElse?.call(context, constraints);

        switch (ResponsiveSize.fromConstraints(constraints)) {
          case ResponsiveSize.compact:
            return compact?.call(context, constraints) ??
                orElse ??
                defaultWidget;
          case ResponsiveSize.medium:
            return medium?.call(context, constraints) ??
                orElse ??
                defaultWidget;
          case ResponsiveSize.expanded:
            return expanded?.call(context, constraints) ??
                orElse ??
                defaultWidget;
        }
      },
    );
  }
}
