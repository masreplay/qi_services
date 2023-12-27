import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';

typedef AppRoute = ({
  String labelText,
  IconData icon,
  IconData selectedIcon,
  PageRouteInfo page,
});

@RoutePage()
class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    // Using routes as [List] of [Record] to change routing behavior for each size.
    final routes = <AppRoute>[
      (
        labelText: l10n.account,
        icon: Icons.wallet,
        selectedIcon: Icons.wallet,
        page: const AccountRoute(),
      ),
      (
        labelText: l10n.transfer,
        icon: Icons.swap_horiz_outlined,
        selectedIcon: Icons.swap_horiz,
        page: const TransferRoute(),
      ),
      (
        labelText: l10n.services,
        icon: Icons.layers_outlined,
        selectedIcon: Icons.layers,
        page: const ServicesRoute(),
      ),
      (
        labelText: l10n.more,
        icon: Icons.more_horiz_outlined,
        selectedIcon: Icons.more_horiz,
        page: const MoreRoute(),
      ),
    ];

    return AutoTabsRouter(
      routes: [for (final route in routes) route.page],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: AppBar(
            title: const AppNameText(),
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
            destinations: [
              for (final route in routes)
                NavigationDestination(
                  icon: Icon(route.icon),
                  selectedIcon: Icon(route.selectedIcon),
                  label: route.labelText,
                ),
            ],
          ),
        );
      },
    );
  }
}

class AppNameText extends StatelessWidget {
  const AppNameText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    print(l10n.localeName);

    return switch (l10n.localeName) {
      "ar" => RowPadded(
          spacing: 4.0,
          children: [
            Text(
              l10n.appName1,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
            Text(
              l10n.appName2,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      _ => RowPadded(
          spacing: 4.0,
          children: [
            Text(
              l10n.appName1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              l10n.appName2,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        )
    };
  }
}
