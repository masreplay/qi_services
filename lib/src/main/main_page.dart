import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/main/main.dart';
import 'package:qi_services/unimplemented.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_page.g.dart';

/// Adaptive destination for each screen
typedef AdaptiveDestination = ({
  /// Label or tooltip
  String labelText,

  /// Icon
  IconData icon,

  /// Route
  PageRouteInfo<void> route,
});

@riverpod
Future<int> getNotificationsCount(GetNotificationsCountRef ref) {
  return ref.read(notificationsRepositoryProvider).getCount();
}

/// Referring to the scaffold as adaptive instead of responsive,
/// Is a way to show that the scaffold is not only
/// Responsive to the screen size, but also to the user's needs and device capabilities.
///
/// Read more:
/// https://m3.material.io/foundations/layout/understanding-layout/parts-of-layout
/// https://m3.material.io/foundations/layout/applying-layout/window-size-classes#9e672e77-6d02-4f2b-841e-34c9136a702b
/// https://m3.material.io/foundations/layout/applying-layout/medium

@RoutePage()
class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final destinations = <AdaptiveDestination>[
      (
        labelText: l10n.account,
        icon: DefaultIcons.account,
        route: const AccountRoute(),
      ),
      (
        labelText: l10n.transfer,
        icon: DefaultIcons.transfer,
        route: const TransferRoute(),
      ),
      (
        labelText: l10n.services,
        icon: DefaultIcons.service,
        route: const ServicesRoute(),
      ),
      (
        labelText: l10n.more,
        icon: DefaultIcons.more,
        route: const MoreRoute(),
      ),
    ];

    return Responsive.when(
      context: context,
      compact: () {
        return _MainPageCompact(destinations: destinations);
      },
      medium: () {
        return _MainPageMedium(destinations: destinations);
      },
      expanded: () {
        return _MainPageExpanded(destinations: destinations);
      },
    );
  }
}

class _NotificationIcon extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = getNotificationsCountProvider;
    final state = ref.watch(provider);

    return Badge(
      isLabelVisible: state.maybeWhen(
        orElse: () => false,
        data: (value) => value > 0,
      ),
      label: state.whenOrNull(
        data: (value) => Text(value.toString()),
      ),
      child: const Icon(DefaultIcons.notifications),
    );
  }
}

class _MainPageCompact extends StatelessWidget {
  const _MainPageCompact({
    required this.destinations,
  });

  final List<AdaptiveDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AutoTabsRouter(
      routes: [
        for (final destination in destinations) destination.route,
      ],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      builder: (context, child) {
        final router = context.tabsRouter;

        final navigation = NavigationBar(
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

        final appBar = AppBar(
          title: const AppNameText(),
          actions: [
            IconButton(
              icon: _NotificationIcon(),
              onPressed: () {
                context.router.pushNativeRoute(
                  MaterialPageRoute(
                    builder: (context) {
                      return const NotificationsPage();
                    },
                  ),
                );
              },
            ),
          ],
        );

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            foregroundColor: colorScheme.onTertiaryContainer,
            backgroundColor: colorScheme.tertiaryContainer,
            elevation: 0,
            onPressed: () {
              _showAddCardBottomSheet(context: context);
            },
            child: const Icon(DefaultIcons.add_card),
          ),
          appBar: appBar,
          body: child,
          bottomNavigationBar: navigation,
        );
      },
    );
  }
}

class _MainPageMedium extends StatelessWidget {
  const _MainPageMedium({
    required this.destinations,
  });

  final List<AdaptiveDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final destinations = <AdaptiveDestination>[
      ...this.destinations,
    ];
    return AutoTabsRouter(
      routes: [
        for (final destination in destinations) destination.route,
        const NotificationsRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      builder: (context, child) {
        final router = context.tabsRouter;

        final navigation = NavigationRail(
          labelType: NavigationRailLabelType.selected,
          selectedIndex: router.activeIndex,
          onDestinationSelected: router.setActiveIndex,
          leading: ColumnPadded(
            children: [
              const AppLogo(),
              // https://m3.material.io/components/menus/guidelines#c17824c1-2008-4b08-972c-03544df5c784
              FloatingActionButton(
                foregroundColor: colorScheme.onTertiaryContainer,
                backgroundColor: colorScheme.tertiaryContainer,
                elevation: 0,
                onPressed: () {
                  _showAddCardBottomSheet(context: context);
                },
                child: const Icon(DefaultIcons.add_card),
              ),
            ],
          ),
          destinations: [
            for (final destination in destinations)
              NavigationRailDestination(
                icon: Icon(destination.icon),
                label: Text(destination.labelText),
              ),
            NavigationRailDestination(
              icon: _NotificationIcon(),
              label: Text(l10n.notifications),
            ),
          ],
        );

        final body = Expanded(child: SafeArea(child: child));

        return Scaffold(
          body: Row(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: navigation,
                      ),
                    ),
                  );
                },
              ),
              const VerticalDivider(thickness: 1, width: 1),
              body,
            ],
          ),
        );
      },
    );
  }
}

class _MainPageExpanded extends StatelessWidget {
  const _MainPageExpanded({required this.destinations});

  final List<AdaptiveDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AutoTabsRouter(
      routes: [
        for (final destination in destinations) destination.route,
        const NotificationsRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      builder: (context, child) {
        final router = context.tabsRouter;

        final navigation = NavigationRail(
          extended: true,
          selectedIndex: router.activeIndex,
          onDestinationSelected: router.setActiveIndex,
          leading: Padding(
            padding: const EdgeInsets.only(bottom: Insets.large),
            child: ColumnPadded(
              mainAxisSize: MainAxisSize.min,
              children: [
                RowPadded(
                  children: const [
                    AppLogo(),
                    AppNameText(),
                  ],
                ),
                FloatingActionButton.extended(
                  foregroundColor: colorScheme.onTertiaryContainer,
                  backgroundColor: colorScheme.tertiaryContainer,
                  elevation: 0,
                  icon: const Icon(DefaultIcons.add_card),
                  label: Text(l10n.addCard),
                  onPressed: () {
                    _showAddCardBottomSheet(context: context);
                  },
                ),
              ],
            ),
          ),
          destinations: [
            for (final destination in destinations)
              NavigationRailDestination(
                icon: Icon(destination.icon),
                label: Text(destination.labelText),
              ),
            NavigationRailDestination(
              icon: _NotificationIcon(),
              label: Text(l10n.notifications),
            ),
          ],
        );

        final body = Expanded(child: SafeArea(child: child));

        return Scaffold(
          body: Row(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: navigation,
                      ),
                    ),
                  );
                },
              ),
              const VerticalDivider(thickness: 1, width: 1),
              body,
            ],
          ),
        );
      },
    );
  }
}

Future<T?> _showAddCardBottomSheet<T>({required BuildContext context}) {
  final l10n = context.l10n;

  return showModalBottomSheet<T>(
    context: context,
    builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(DefaultIcons.qr_code_scanner),
            title: Text(l10n.addCardQRScanTitle),
            subtitle: Text(l10n.addCardQRScanSubtitle),
            onTap: () {
              context.router.pop();
              showUnimplementedFeature(context: context);
            },
          ),
        ],
      );
    },
  );
}
