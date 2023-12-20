import 'package:flutter/material.dart';
import 'package:qi_services/home_screen.dart';

import 'theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MainTheme();

    return MaterialApp(
      theme: theme.buildLight(),
      home: const HomeScreen(),
    );
  }
}
