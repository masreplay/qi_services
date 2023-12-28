import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/main/adaptive_destination.dart';

/// https://m3.material.io/foundations/layout/understanding-layout/parts-of-layout
/// https://m3.material.io/foundations/layout/applying-layout/window-size-classes#9e672e77-6d02-4f2b-841e-34c9136a702b
/// Referring to the scaffold as adaptive instead of responsive,
/// is a way to show that the scaffold is not only
/// responsive to the screen size, but also to the user's needs and device capabilities.
@RoutePage()
class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final account = (
      labelText: l10n.account,
      icon: DefaultIcons.account,
      route: const AccountRoute(),
    );

    final transfer = (
      labelText: l10n.transfer,
      icon: DefaultIcons.transfer,
      route: const TransferRoute(),
    );

    final services = (
      labelText: l10n.services,
      icon: DefaultIcons.service,
      route: const ServicesRoute(),
    );

    final more = (
      labelText: l10n.more,
      icon: DefaultIcons.more,
      route: const MoreRoute(),
    );

    final addCard = (
      labelText: l10n.addCard,
      icon: DefaultIcons.add_card,
      route: const AddCardRoute()
    );

    final notifications = (
      labelText: l10n.notifications,
      icon: DefaultIcons.notifications,
      route: const NotificationsRoute()
    );

    final destinations = [account, transfer, services, more];

    return ResponsiveLayoutBuilder(
      builder: (context, constraints, size) {
        switch (size) {
          case ResponsiveSize.compact:
            return AutoTabsRouter(
              routes: [
                for (final destination in destinations) destination.route,
              ],
              transitionBuilder: (context, child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              builder: (context, child) {
                final router = context.tabsRouter;

                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    foregroundColor: colorScheme.onTertiaryContainer,
                    backgroundColor: colorScheme.tertiaryContainer,
                    elevation: 0,
                    onPressed: () => context.router.push(addCard.route),
                    child: Icon(addCard.icon),
                  ),
                  appBar: AdaptiveScaffoldCompactAppBar(
                    destinations: [notifications],
                  ),
                  body: child,
                  bottomNavigationBar: AdaptiveScaffoldCompactNavigationBar(
                    router: router,
                    destinations: destinations,
                  ),
                );
              },
            );
          case ResponsiveSize.medium:
            return const Text("medium");
          case ResponsiveSize.expanded:
            return const Text("expanded");
        }
      },
    );
  }
}

/// For [ResponsiveSize.compact]
/// never use [AppBar.leading]
/// it add extra padding to the left of the app name.
class AdaptiveScaffoldCompactAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AdaptiveScaffoldCompactAppBar({
    super.key,
    required this.destinations,
  });

  final List<AdaptiveDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: RowPadded(
        spacing: Insets.small,
        children: [
          // AppLogo(
          //   dimension: IconSizes.large,
          //   borderRadius: BorderRadius.circular(8.0),
          // ),
          Expanded(
            child: ColumnPadded(
              spacing: Insets.xsmall,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppNameText(),
                // Animate(
                //   effects: const [SlideEffect(duration: Time.short)],
                //   child: Text(
                //     context.l10n.appNameSlogan,
                //     style: textTheme.bodySmall?.copyWith(
                //       color: colorScheme.onSurfaceVariant,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        for (final destination in destinations)
          IconButton(
            icon: Icon(destination.icon),
            onPressed: () {
              context.router.push(destination.route);
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AdaptiveScaffoldCompactNavigationBar extends StatelessWidget {
  const AdaptiveScaffoldCompactNavigationBar({
    super.key,
    required this.router,
    required this.destinations,
  });

  final TabsRouter router;
  final List<AdaptiveDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: router.activeIndex,
      onDestinationSelected: router.setActiveIndex,
      destinations: [
        for (final destination in destinations)
          NavigationDestination(
            icon: Icon(destination.icon),
            label: destination.labelText,
          ),
      ],
    );
  }
}
