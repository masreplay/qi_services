import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:qi_services/src/main/more/m3_alert.dart';
import 'package:qi_services/unimplemented.dart';

/// https://m3.material.io/foundations/layout/applying-layout/window-size-classes#35037e9b-550e-4fc0-9edd-4ef8e7a55b02
/// A settings or more view offering quick navigation and actions is a good use of two panes in a medium layout
@RoutePage()
class MorePage extends HookConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authentication = ref.watch(authenticationProvider);

    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ColumnPadded(
                children: [
                  Text(
                    authentication?.name ?? "",
                    style: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  // the `+` sign should always be on the left side of the phone number
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      authentication?.phone ?? "",
                      style: textTheme.labelLarge?.copyWith(
                        // prominent
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            M3Alert.warning(
              title: Text(l10n.finishRegistrationTitle),
              subtitle: Text(l10n.finishRegistrationSubtitle),
              description: Text(l10n.finishRegistrationDescription),
              image: Assets.illustrations.finishRegistration.svg(),
              onPressed: () {
                showUnimplementedFeature(context: context);
              },
            ),
            ListTile(
              title: Text(l10n.shareAppWithFriendsTitle),
              subtitle: Text(l10n.shareAppWithFriendsSubtitle),
              leading: Icon(Icons.adaptive.share_outlined),
              trailing: TextButton(
                onPressed: () {
                  showUnimplementedFeature(context: context);
                },
                child: Text(l10n.share),
              ),
            ),
            ListTile(
              title: Text(l10n.settings),
              leading: const Icon(Icons.settings_outlined),
              onTap: () {
                context.router.push(const SettingsRoute());
              },
            ),
            ListTile(
              title: Text(l10n.rateUs),
              leading: const Icon(Icons.star_outline_rounded),
              onTap: () {
                showUnimplementedFeature(context: context);
              },
            ),
            ListTile(
              title: Text(l10n.rateCallCenterService),
              leading: const Icon(Icons.call_outlined),
              onTap: () {
                showUnimplementedFeature(context: context);
              },
            ),
            ListTile(
              title: Text(l10n.aboutApp),
              leading: const Icon(Icons.info_outline),
              onTap: () {
                showUnimplementedFeature(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
