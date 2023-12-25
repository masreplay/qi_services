import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:useful_hook/useful_hook.dart';

import 'settings/settings_page.dart';

class MorePage extends HookConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authentication = ref.watch(authenticationProvider);
    final logoutState = useAsyncState();

    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    const divider = Divider(
      color: Colors.grey,
      height: 1.0,
      indent: 16.0,
      endIndent: 16.0,
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.more)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // the `+` sign should always be on the left side of the phone number
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  authentication?.phone ?? "",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ColumnPadded(
                spacing: 4.0,
                children: [
                  _MoreListTile(
                    titleText: l10n.settings,
                    leading: const _MoreIcon(
                      icon: Icons.settings,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.vermilion,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SettingsPage(),
                        ),
                      );
                    },
                  ),
                  divider,
                  _MoreListTile(
                    titleText: l10n.share,
                    leading: _MoreIcon(
                      icon: Icons.adaptive.share,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.green,
                    ),
                    onTap: () {},
                  ),
                  divider,
                  _MoreListTile(
                    titleText: l10n.rateUs,
                    leading: const _MoreIcon(
                      icon: Icons.star,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.yellow,
                    ),
                    onTap: () {},
                  ),
                  divider,
                  _MoreListTile(
                    titleText: l10n.rateCallCenterService,
                    leading: const _MoreIcon(
                      icon: Icons.call_outlined,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.indigo,
                    ),
                    onTap: () {},
                  ),
                  divider,
                  _MoreListTile(
                    titleText: l10n.aboutUs,
                    leading: const _MoreIcon(
                      icon: Icons.info_outline,
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.indigo,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (logoutState.value.isLoading) const LinearProgressIndicator(),
            ListTile(
              title: Text(l10n.logout),
              tileColor: colorScheme.surface,
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.0,
                color: colorScheme.onSurface,
              ),
              leading: const _MoreIcon(
                icon: Icons.logout,
                foregroundColor: Colors.white,
                backgroundColor: AppColors.vermilion,
              ),
              onTap: () {
                logoutState(logout(ref: ref));
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _MoreListTile extends StatelessWidget {
  const _MoreListTile({
    required this.titleText,
    required this.leading,
    required this.onTap,
  });

  final String titleText;
  final VoidCallback onTap;
  final _MoreIcon leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(titleText),
      onTap: onTap,
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16.0,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      leading: leading,
    );
  }
}

class _MoreIcon extends StatelessWidget {
  const _MoreIcon({
    required this.icon,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  final IconData icon;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(
        icon,
        color: foregroundColor,
      ),
    );
  }
}
