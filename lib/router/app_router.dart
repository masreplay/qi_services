import 'package:auto_route/auto_route.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:qi_services/src/main/main.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        initial: true,
        page: MainRoute.page,
        children: [
          AutoRoute(
            initial: true,
            page: AccountRoute.page,
          ),
          AutoRoute(
            path: 'transfer',
            page: TransferRoute.page,
          ),
          AutoRoute(
            path: 'services',
            page: ServicesRoute.page,
          ),
          AutoRoute(
            path: 'more',
            page: MoreRoute.page,
          ),
        ],
      ),
      AutoRoute(
        path: 'login',
        page: LoginRoute.page,
      ),
      AutoRoute(
        path: 'settings',
        page: SettingsRoute.page,
      ),
    ];
  }
}
