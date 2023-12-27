import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/api/models/logout_model.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';

import 'settings_provider.dart';

@RoutePage()
class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: Column(
        children: [
          ListTile(
            title: Text(l10n.theme),
            leading: Icon(
              DefaultAppIcons.theme,
              color: colorScheme.primary,
            ),
            subtitle: Text(settings.themeMode.localize(l10n)),
            onTap: () {
              showThemeDialog(context: context);
            },
          ),
          ListTile(
            title: Text(l10n.language),
            leading: Icon(
              Icons.language,
              color: colorScheme.primary,
            ),
            subtitle: Text(
              settings.locale?.localize(l10n) ?? l10n.systemLanguage,
            ),
            onTap: () {
              showLanguageDialog(context: context);
            },
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.logout),
            tileColor: colorScheme.surface,
            leading: const Icon(Icons.logout),
            onTap: () {
              showLogoutDialog(context: context);
            },
          ),
        ],
      ),
    );
  }
}

Future<void> showLogoutDialog({
  required BuildContext context,
}) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      final l10n = context.l10n;

      return HookConsumer(
        builder: (context, ref, child) {
          final state = useAsyncState<LogoutResponse>();
          return AlertDialog(
            title: Text(l10n.logoutConfirmationTitle),
            actions: [
              TextButton(
                onPressed: () {
                  context.router.pop();
                },
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: state.value.isLoading
                    ? null
                    : () async {
                        showLoadingBottomSheet(
                          context: context,
                          titleText: l10n.loggingOut,
                        );
                        state(logout(ref: ref));
                      },
                child: Text(l10n.logout),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> showThemeDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      final l10n = context.l10n;

      return HookConsumer(
        builder: (context, ref, child) {
          final provider = settingsProvider;
          final currentThemeMode = ref.watch(provider).themeMode;

          return AlertDialog(
            title: Text(l10n.theme),
            icon: const Icon(DefaultAppIcons.theme),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final themeMode in ThemeMode.values)
                  RadioListTile<ThemeMode>(
                    title: Text(themeMode.localize(context.l10n)),
                    value: themeMode,
                    groupValue: currentThemeMode,
                    onChanged: (value) {
                      ref.read(provider.notifier).setThemeMode(value!);
                      context.router.pop();
                    },
                  ),
              ],
            ),
          );
        },
      );
    },
  );
}

Future<void> showLanguageDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      final l10n = context.l10n;

      return HookConsumer(
        builder: (context, ref, child) {
          final provider = settingsProvider;
          final locale = ref.watch(provider).locale;

          final List<Locale> languages = [
            ...AppLocalizations.supportedLocales,
          ];

          return AlertDialog(
            icon: const Icon(Icons.language),
            title: Text(l10n.language),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<Locale?>(
                  title: Text(context.l10n.systemLanguage),
                  value: null,
                  groupValue: locale,
                  onChanged: (value) {
                    ref.read(provider.notifier).setLocale(null);
                    context.router.pop();
                  },
                ),
                for (final language in languages)
                  RadioListTile<Locale?>(
                    title: Text(language.localize(l10n)),
                    value: language,
                    groupValue: locale,
                    onChanged: (value) {
                      ref.read(provider.notifier).setLocale(value);
                      context.router.pop();
                    },
                  ),
              ],
            ),
          );
        },
      );
    },
  );
}

extension on ThemeMode {
  String localize(AppLocalizations l10n) {
    return switch (this) {
      ThemeMode.system => l10n.systemTheme,
      ThemeMode.light => l10n.lightTheme,
      ThemeMode.dark => l10n.darkTheme,
    };
  }
}

extension on Locale {
  String localize(AppLocalizations l10n) {
    return switch (this) {
      const Locale("ar") => "العربية",
      const Locale("en") => "English",
      _ => "",
    };
  }
}
