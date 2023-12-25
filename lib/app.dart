import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/l10n/lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:qi_services/src/main/authentication_provider.dart';
import 'package:qi_services/src/main/main.dart';
import 'package:qi_services/src/main/settings_provider.dart';

import 'theme/main_theme.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = MainTheme();
    final settings = ref.watch(settingsProvider);
    final authentication = ref.watch(authenticationProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: settings.themeMode,
      theme: theme.buildLight(),
      darkTheme: theme.buildDark(),
      home: authentication == null ? const LoginPage() : const MainPage(),
    );
  }
}
