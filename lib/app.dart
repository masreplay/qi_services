import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/l10n/lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:qi_services/src/main/main.dart';

import 'theme/main_theme.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final authentication = ref.watch(authenticationProvider);

    final theme = MainTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: settings.themeMode,
      theme: theme.buildLight(),
      darkTheme: theme.buildDark(),
      // simple check for authentication it's better to use guards
      // and auto_route or go_router packages
      home: authentication == null ? const LoginPage() : const MainPage(),
    );
  }
}
