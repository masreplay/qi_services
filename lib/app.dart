import 'package:flutter/material.dart';
import 'src/authentication/login/login_page.dart';

import 'theme/main_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MainTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.buildLight(),
      home: const LoginPage(),
    );
  }
}
