import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/l10n/extension.dart';
import 'package:useful_hook/useful_hook.dart';

import 'account/account.dart';
import 'more/more.dart';
import 'services/services.dart';
import 'transfer/transfer.dart';

@RoutePage()
class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = useState(0);

    final l10n = context.l10n;

    // Using routes as [List] of [Record] to change routing behavior for each size.
    final routes = [
      (
        labelText: l10n.account,
        icon: Icons.wallet,
        selectedIcon: Icons.wallet,
        page: const AccountPage(),
      ),
      (
        labelText: l10n.transfer,
        icon: Icons.swap_horiz_outlined,
        selectedIcon: Icons.swap_horiz,
        page: const TransferPage(),
      ),
      (
        labelText: l10n.services,
        icon: Icons.layers_outlined,
        selectedIcon: Icons.layers,
        page: const ServicesPage(),
      ),
      (
        labelText: l10n.more,
        icon: Icons.more_horiz_outlined,
        selectedIcon: Icons.more_horiz,
        page: const MorePage(),
      ),
    ];

    return Scaffold(
      body: routes[index.value].page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index.value,
        onDestinationSelected: index.update,
        destinations: List.generate(
          routes.length,
          (index) {
            final route = routes[index];
            return NavigationDestination(
              icon: Icon(route.icon),
              selectedIcon: Icon(route.selectedIcon),
              label: route.labelText,
            );
          },
        ),
      ),
    );
  }
}
