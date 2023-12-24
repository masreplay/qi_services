import 'package:flutter/material.dart';
import 'package:qi_services/l10n/lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';

import 'theme/main_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MainTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme.buildLight(),
      darkTheme: theme.buildDark(),
      home: const LoginPage(),
    );
  }
}
