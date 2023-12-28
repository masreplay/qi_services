import 'package:auto_route/auto_route.dart';
import 'package:qi_services/common_lib.dart';

/// Adaptive destination for each screen
typedef AdaptiveDestination = ({
  /// Label or tooltip
  String labelText,

  /// Icon
  IconData icon,

  /// Route
  PageRouteInfo<void> route,
});
