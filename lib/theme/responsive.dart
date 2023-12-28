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


/// 
/// No need to prevent unnecessary rebuilds because it's already implemented in [LayoutBuilder]
class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    ResponsiveSize size,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = ResponsiveSize.fromConstraints(constraints);
        return builder(context, constraints, size);
      },
    );
  }
}
