import 'package:qi_services/common_lib.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Assets.app.logo.image(
            width: 100.0,
            height: 100.0,
          ),
        ),
        Text(
          context.l10n.appName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
