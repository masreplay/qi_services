import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/router/router_extension.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:qi_services/src/main/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';
part 'app_router.gr.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
Raw<AppRouter> appRouter(AppRouterRef ref) =>
    AppRouter._(ref, navigatorKey: navigatorKey);

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final Ref _ref;
  AppRouter._(this._ref, {super.navigatorKey});

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

    final isNotAuthenticated = authentication == null;
    if (isNotAuthenticated) {
      router.replace(defaultNotAuthenticatedRoute);
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

    final isNotAuthenticated = authentication == null;
    if (isNotAuthenticated) {
      resolver.next(true);
    } else {
      router.replace(defaultAuthenticatedRoute);
    }
  }
}
