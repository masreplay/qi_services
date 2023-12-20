import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Qi Services",
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(),
                ),
                const SizedBox.square(dimension: 16),
                Expanded(
                  flex: 4,
                  child: TextFormField(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
