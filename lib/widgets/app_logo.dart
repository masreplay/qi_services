import 'package:qi_services/common_lib.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({
    super.key,
    this.fontSize,
  });

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return switch (l10n.localeName) {
      "ar" => RowPadded(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.0,
          children: [
            Text(
              l10n.appName1,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: fontSize,
              ),
            ),
            Text(
              l10n.appName2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      _ => RowPadded(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.0,
          children: [
            Text(
              l10n.appName1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            Text(
              l10n.appName2,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: fontSize,
              ),
            ),
          ],
        )
    };
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.dimension = 56.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
  });

  final double dimension;

  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Assets.logo.appLogo.image(
          width: dimension,
          height: dimension,
          fit: BoxFit.cover,
        ),
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
