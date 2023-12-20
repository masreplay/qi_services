import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/l10n/extension.dart';
import 'package:useful_hook/useful_hook.dart';

import 'account_page.dart';
import 'more_page.dart';
import 'services_page.dart';
import 'transfer_page.dart';

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
        activeIcon: Icons.wallet,
        page: const AccountPage(),
      ),
      (
        labelText: l10n.transfer,
        icon: Icons.swap_horiz_outlined,
        activeIcon: Icons.swap_horiz,
        page: const TransferPage(),
      ),
      (
        labelText: l10n.services,
        icon: Icons.layers_outlined,
        activeIcon: Icons.layers,
        page: const ServicesPage(),
      ),
      (
        labelText: l10n.more,
        icon: Icons.more_horiz_outlined,
        activeIcon: Icons.more_horiz,
        page: const MorePage(),
      ),
    ];

    return Scaffold(
      body: routes[index.value].page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index.value,
        onTap: index.update,
        elevation: 10.0,
        showUnselectedLabels: true,
        iconSize: 28.0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        items: List.generate(
          routes.length,
          (index) {
            final route = routes[index];
            return BottomNavigationBarItem(
              icon: Icon(route.icon),
              activeIcon: Icon(route.activeIcon),
              label: route.labelText,
              backgroundColor: Theme.of(context).colorScheme.surface,
            );
          },
        ),
      ),
    );
  }
}
