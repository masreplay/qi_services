import 'package:qi_services/common_lib.dart';

/// https://m3.material.io/foundations/layout/applying-layout/window-size-classes
/// https://developer.android.com/guide/topics/large-screens/support-different-screen-sizes#window_size_classes
enum ResponsiveSize {
  /// Phone in portrait
  compact(min: 0, max: 599),

  /// Tablet in portrait
  /// Foldable in portrait (unfolded)
  medium(min: 600, max: 839),

  /// Phone in landscape
  /// Tablet in landscape
  /// Foldable in landscape (unfolded)
  /// Desktop
  expanded(min: 840, max: double.infinity);

  const ResponsiveSize({required this.min, required this.max});

  /// The minimum width of the screen
  final double min;

  /// The maximum width of the screen
  final double max;

  factory ResponsiveSize.fromConstraints(BoxConstraints constraints) {
    final width = constraints.maxWidth;

    if (width >= expanded.min) {
      return expanded;
    } else if (width >= medium.min) {
      return medium;
    } else {
      return compact;
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

  const ResponsiveLayoutBuilder.maybeWhen({
    super.key,
    required ResponsiveWidgetBuilder this.orElse,
    this.compact,
    this.medium,
    this.expanded,
  });

  /// https://m3.material.io/foundations/layout/applying-layout/compact
  final ResponsiveWidgetBuilder? compact;

  /// https://m3.material.io/foundations/layout/applying-layout/medium
  final ResponsiveWidgetBuilder? medium;

  /// https://m3.material.io/foundations/layout/applying-layout/expanded
  final ResponsiveWidgetBuilder? expanded;

  final ResponsiveWidgetBuilder? orElse;

  @override
  Widget build(BuildContext context) {
    const Widget defaultWidget = SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final orElse = this.orElse?.call(context, constraints);
        final ResponsiveSize size = // ResponsiveSize.medium ??
            ResponsiveSize.fromConstraints(constraints);
        switch (size) {
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
