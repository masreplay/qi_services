import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/main/notifications_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_page.g.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final notificationsCount = ref.watch(getNotificationsCountProvider);

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

    final Widget notificationIcon = Badge(
      isLabelVisible: notificationsCount.maybeWhen(
        orElse: () => false,
        data: (value) => value > 0,
      ),
      label: notificationsCount.whenOrNull(
        data: (value) => Text(value.toString()),
      ),
      child: Icon(notifications.icon),
    );

    final mainDestinations = [account, transfer, services, more];

    return ResponsiveLayoutBuilder.when(
      compact: (context, constraints) {
        return AutoTabsRouter(
          routes: [
            for (final destination in mainDestinations) destination.route,
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
                for (final destination in mainDestinations)
                  NavigationDestination(
                    icon: Icon(destination.icon),
                    label: destination.labelText,
                  ),
              ],
            );

            final appBar = AppBar(
              title: const AppNameText(),
              actions: [
                for (final destination in [notifications])
                  IconButton(
                    icon: Icon(destination.icon),
                    onPressed: () {
                      context.router.push(destination.route);
                    },
                  ),
              ],
            );

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                foregroundColor: colorScheme.onTertiaryContainer,
                backgroundColor: colorScheme.tertiaryContainer,
                elevation: 0,
                onPressed: () => context.router.push(addCard.route),
                child: Icon(addCard.icon),
              ),
              appBar: appBar,
              body: child,
              bottomNavigationBar: navigation,
            );
          },
        );
      },
      medium: (context, constraints) {
        return AutoTabsRouter(
          routes: [
            for (final destination in mainDestinations) destination.route,
            notifications.route,
          ],
          transitionBuilder: (context, child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          builder: (context, child) {
            final router = context.tabsRouter;

            final navigation = SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    labelType: NavigationRailLabelType.selected,
                    selectedIndex: router.activeIndex,
                    onDestinationSelected: router.setActiveIndex,
                    leading: ColumnPadded(
                      children: [
                        const AppLogo(
                          dimension: 56.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        FloatingActionButton(
                          foregroundColor: colorScheme.onTertiaryContainer,
                          backgroundColor: colorScheme.tertiaryContainer,
                          elevation: 0,
                          onPressed: () => context.router.push(addCard.route),
                          child: Icon(addCard.icon),
                        ),
                      ],
                    ),
                    destinations: [
                      for (final destination in mainDestinations)
                        NavigationRailDestination(
                          icon: Icon(destination.icon),
                          label: Text(destination.labelText),
                        ),
                      NavigationRailDestination(
                        icon: notificationIcon,
                        label: Text(notifications.labelText),
                      ),
                    ],
                  ),
                ),
              ),
            );

            final body = Expanded(child: SafeArea(child: child));

            return Scaffold(
              body: Row(
                children: [
                  navigation,
                  const VerticalDivider(thickness: 1, width: 1),
                  body,
                ],
              ),
            );
          },
        );
      },
      expanded: (context, constraints) {
        AppBar(
          title: RowPadded(
            spacing: Insets.small,
            children: [
              AppLogo(
                dimension: IconSizes.large,
                borderRadius: BorderRadius.circular(8.0),
              ),
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
            for (final destination in mainDestinations)
              IconButton(
                icon: Icon(destination.icon),
                onPressed: () {
                  context.router.push(destination.route);
                },
              ),
          ],
        );
        return Container();
      },
    );
  }
}
