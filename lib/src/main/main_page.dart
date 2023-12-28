import 'package:auto_route/auto_route.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';

typedef AppRoute = ({
  String labelText,
  IconData icon,
  PageRouteInfo page,
});

@RoutePage()
class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Using routes as [List] of [Record] to change routing behavior for each size.
    final routes = <AppRoute>[
      (
        labelText: l10n.account,
        icon: DefaultIcons.account,
        page: const AccountRoute(),
      ),
      (
        labelText: l10n.transfer,
        icon: DefaultIcons.transfer,
        page: const TransferRoute(),
      ),
      (
        labelText: l10n.services,
        icon: DefaultIcons.service,
        page: const ServicesRoute(),
      ),
      (
        labelText: l10n.more,
        icon: DefaultIcons.more,
        page: const MoreRoute(),
      ),
    ];

    return AutoTabsRouter(
      routes: [for (final route in routes) route.page],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: AppBar(
            title: RowPadded(
              children: [
                // Never use [AppBar.leading]
                // it add extra padding to the left of the app name.
                AppLogo(
                  dimension: 36.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppNameText(),
                    Animate(
                      effects: const [
                        SlideEffect(
                          begin: Offset(
                            SlideEffect.neutralSlide,
                            SlideEffect.defaultSlide,
                          ),
                          end: Offset(
                            SlideEffect.neutralSlide,
                            SlideEffect.neutralSlide,
                          ),
                          duration: Time.medium,
                        ),
                      ],
                      child: Text(
                        l10n.appNameSlogan,
                        style: textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ).animate().slideY(),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
            ],
          ),
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: List.generate(routes.length, (index) {
              final route = routes[index];
              final selected = index == tabsRouter.activeIndex;

              // [NavigationBarTheme] is used to change the style of the label.
              return NavigationBarTheme(
                data: NavigationBarThemeData(
                  labelTextStyle: MaterialStateProperty.all(
                    textTheme.bodySmall?.copyWith(
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                child: NavigationDestination(
                  icon: Icon(route.icon),
                  label: route.labelText,
                  enabled: true,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
