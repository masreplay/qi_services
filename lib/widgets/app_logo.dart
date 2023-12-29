import 'package:qi_services/common_lib.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return switch (l10n.localeName) {
      "ar" => RowPadded(
          spacing: 4.0,
          children: [
            Text(
              l10n.appName1,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
            Text(
              l10n.appName2,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      _ => RowPadded(
          spacing: 4.0,
          children: [
            Text(
              l10n.appName1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              l10n.appName2,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        )
    };
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    required this.dimension,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(Radiuses.small),
    ),
  });

  final double dimension;

  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Assets.logo.appLogo.image(
        width: dimension,
        height: dimension,
      ),
    );
  }
}

class AppSloganLogo extends StatelessWidget {
  const AppSloganLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      children: [
        AppLogo(
          dimension: 100,
          borderRadius: BorderRadius.circular(12.0),
        ),
        Text(
          l10n.appName,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
