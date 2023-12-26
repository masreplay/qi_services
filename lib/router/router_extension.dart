import 'package:auto_route/auto_route.dart';

import 'app_router.dart';

const LoginRoute defaultNotAuthenticatedRoute = LoginRoute();
const MainRoute defaultAuthenticatedRoute = MainRoute();

extension StackRouterX on StackRouter {
  Future<T?> replaceNotAuthenticatedRoute<T extends Object?>() {
    return replace<T>(defaultNotAuthenticatedRoute);
  }

  Future<T?> replaceAuthenticatedRoute<T extends Object?>() {
    return replace<T>(defaultAuthenticatedRoute);
  }
}
