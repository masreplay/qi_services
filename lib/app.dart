import 'package:flutter/material.dart';
import 'login_screen.dart';

import 'theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MainTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.buildLight(),
      home: const LoginScreen(),
    );
  }
}
