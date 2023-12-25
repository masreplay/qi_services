import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:useful_hook/useful_hook.dart';

@RoutePage()
class MorePage extends HookConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authentication = ref.watch(authenticationProvider);
    final logoutState = useAsyncState();

    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

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
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            ColumnPadded(
              spacing: 4.0,
              children: [
                ListTile(
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    context.router.push(const SettingsRoute());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.adaptive.share),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.star),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.call_outlined),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  onTap: () {},
                ),
              ],
            ),
            const Spacer(),
            if (logoutState.value.isLoading) const LinearProgressIndicator(),
            ListTile(
              title: Text(l10n.logout),
              tileColor: colorScheme.surface,
              leading: const Icon(Icons.logout),
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
