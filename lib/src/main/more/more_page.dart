import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';

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
      appBar: AppBar(title: Text(l10n.more)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // the `+` sign should always be on the left side of the phone number
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      authentication?.phone ?? "",
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Radiuses.medium),
                ),
                contentPadding: const EdgeInsets.all(Insets.medium),
                tileColor: colorScheme.tertiary,
                textColor: colorScheme.onTertiary,
                iconColor: colorScheme.onTertiary,
                title: Text(l10n.finishRegistrationTitle),
                subtitle: Text(l10n.finishRegistrationSubtitle),
                leading: Icon(
                  Icons.lightbulb_outline,
                  color: colorScheme.onTertiary,
                ),
                trailing: Icon(Icons.adaptive.arrow_forward_rounded),
                onTap: () {
                  showTileBottomSheet(
                    context: context,
                    title: Text(l10n.finishRegistrationTitle),
                    subtitle: Text(l10n.finishRegistrationDescription),
                    leading: Assets.illustrations.finishRegistration.svg(),
                    onTap: () {},
                  );
                },
              ),
            ),

            ListTile(
              title: Text(l10n.shareAppWithFriendsTitle),
              subtitle: Text(l10n.shareAppWithFriendsSubtitle),
              leading: Icon(Icons.adaptive.share_outlined),
              trailing: TextButton(
                onPressed: () {},
                child: Text(l10n.share),
              ),
              onTap: () {},
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
              onTap: () {},
            ),
            ListTile(
              title: Text(l10n.rateCallCenterService),
              leading: const Icon(Icons.call_outlined),
              onTap: () {},
            ),
            ListTile(
              title: Text(l10n.aboutApp),
              leading: const Icon(Icons.info_outline),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Future<T?> showTileBottomSheet<T>({
  required BuildContext context,
  required Widget title,
  required Widget subtitle,
  required Widget leading,
  required VoidCallback onTap,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (context) {
      final l10n = context.l10n;
      final theme = Theme.of(context);
      final textTheme = theme.textTheme;

      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.medium,
          vertical: Insets.large,
        ),
        child: ColumnPadded(
          spacing: Insets.medium,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RowPadded(
              spacing: Insets.medium,
              children: [
                Expanded(
                  flex: 3,
                  child: ColumnPadded(
                    spacing: Insets.medium,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DefaultTextStyle(
                        style: textTheme.titleLarge!,
                        child: title,
                      ),
                      DefaultTextStyle(
                        style: textTheme.bodyMedium!,
                        child: subtitle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: leading,
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: onTap,
              child: Text(l10n.continueOption),
            ),
          ],
        ),
      );
    },
  );
}
