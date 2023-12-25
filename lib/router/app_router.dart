import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:qi_services/src/main/main.dart';

part 'app_router.gr.dart';

final Provider<AppRouter> appRouterProvider = Provider(AppRouter._);

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final Ref _ref;
  AppRouter._(this._ref);

  _AuthenticatedGuard get _authenticatedGuard => _AuthenticatedGuard(_ref);
  _NotAuthenticatedGuard get _notAuthenticatedGuard =>
      _NotAuthenticatedGuard(_ref);

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        initial: true,
        page: MainRoute.page,
        guards: [_authenticatedGuard],
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
        path: '/settings',
        page: SettingsRoute.page,
        guards: [_authenticatedGuard],
      ),
      // auth
      AutoRoute(
        path: '/auth/login',
        page: LoginRoute.page,
        guards: [_notAuthenticatedGuard],
      ),
    ];
  }
}

class _AuthenticatedGuard extends AutoRouteGuard {
  final Ref _ref;
  _AuthenticatedGuard(this._ref);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authentication = _ref.read(authenticationProvider);
    print('AuthenticatedGuard: $authentication');

    final isNotAuthenticated = authentication == null;
    if (isNotAuthenticated) {
      router.replace(const LoginRoute());
    } else {
      resolver.next(true);
    }
  }
}

class _NotAuthenticatedGuard extends AutoRouteGuard {
  final Ref _ref;
  _NotAuthenticatedGuard(this._ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authentication = _ref.read(authenticationProvider);
    print('NotAuthenticationGuard: $authentication');
    final isNotAuthenticated = authentication == null;
    if (isNotAuthenticated) {
      resolver.next(true);
    } else {
      router.replace(const MainRoute());
    }
  }
}
