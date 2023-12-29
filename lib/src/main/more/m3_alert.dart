import 'package:auto_route/auto_route.dart';
import 'package:qi_services/common_lib.dart';

/// Associated with [M3Alert]
enum _M3AlertVariant { warning }

/// implementation:
/// https://m3.material.io/styles/color/system/overview#9e93d40d-7733-4c10-ba68-e3ffb529bb5c
/// also
/// https://m3.material.io/components/cards#behavior
class M3Alert extends StatelessWidget {
  const M3Alert.secondary({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.description,
    this.spacing,
    this.onPressed,
    this.margin,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
  }) : _type = _M3AlertVariant.warning;

  final _M3AlertVariant _type;

  final Widget title;

  final Widget subtitle;

  final Widget? description;

  final Widget image;

  final VoidCallback? onPressed;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final BorderRadius? borderRadius;

  final double? spacing;

  final Color? backgroundColor;

  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final theme = M3AlertTheme.of(context);

    final backgroundColor = this.backgroundColor ??
        theme.backgroundColor ??
        colorScheme.secondaryContainer;

    final foregroundColor = this.foregroundColor ??
        theme.foregroundColor ??
        colorScheme.onSecondaryContainer;

    final margin = this.margin ??
        theme.margin ??
        const EdgeInsets.symmetric(
          horizontal: Insets.medium,
          vertical: Insets.small,
        );

    final padding =
        this.padding ?? theme.padding ?? const EdgeInsets.all(Insets.medium);

    final spacing = this.spacing ?? this.spacing ?? Insets.medium;

    final borderRadius = this.borderRadius ??
        theme.borderRadius ??
        const BorderRadius.all(Radius.circular(Insets.medium));

    final Widget title = this.title;
    final Widget subtitle = this.subtitle;
    final Widget description = this.description ?? subtitle;

    final Icon leading = switch (_type) {
      _M3AlertVariant.warning => const Icon(Icons.lightbulb_outline_rounded),
    };

    return Card(
      margin: margin,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      color: backgroundColor,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          _showAlertBottomSheet(
            context: context,
            title: title,
            subtitle: description,
            leading: image,
            onTap: () {
              context.router.pop();
              onPressed?.call();
            },
          );
        },
        child: Padding(
          padding: padding,
          child: RowPadded(
            spacing: spacing,
            children: [
              IconTheme(
                data: IconThemeData(color: foregroundColor),
                child: leading,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: textTheme.titleMedium!.copyWith(
                        color: foregroundColor,
                      ),
                      child: title,
                    ),
                    DefaultTextStyle(
                      style: textTheme.titleSmall!.copyWith(
                        color: foregroundColor,
                      ),
                      child: subtitle,
                    ),
                  ],
                ),
              ),
              if (onPressed != null)
                IconTheme(
                  data: IconThemeData(color: foregroundColor),
                  child: Icon(Icons.adaptive.arrow_forward_rounded),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [M3Alert] is used to configure the default values for [M3Alert]
Future<T?> _showAlertBottomSheet<T>({
  required BuildContext context,
  required Widget title,
  required Widget subtitle,
  required Widget leading,
  required VoidCallback onTap,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (context) {
      final l10n = context.l10n;
      final theme = Theme.of(context);
      final textTheme = theme.textTheme;

      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.large,
          vertical: Insets.large,
        ),
        child: ColumnPadded(
          spacing: Insets.medium,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RowPadded(
              spacing: Insets.medium,
              children: [
                Expanded(
                  flex: 3,
                  child: ColumnPadded(
                    spacing: Insets.small,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DefaultTextStyle(
                        style: textTheme.titleLarge!,
                        child: title,
                      ),
                      DefaultTextStyle(
                        style: textTheme.bodyMedium!,
                        child: subtitle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: leading,
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: onTap,
              child: Text(l10n.continueOption),
            ),
          ],
        ),
      );
    },
  );
}

/// [M3AlertTheme] is used to configure the default values for [M3Alert]
class M3AlertThemeData {
  const M3AlertThemeData({
    this.backgroundColor,
    this.foregroundColor,
    this.margin,
    this.padding,
    this.borderRadius,
    this.spacing,
  });

  final double? spacing;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final BorderRadius? borderRadius;
}

/// [M3AlertTheme] is used to configure the default values for [M3Alert]
class M3AlertTheme extends InheritedWidget {
  const M3AlertTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final M3AlertThemeData data;

  static M3AlertThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<M3AlertTheme>();
    return theme?.data ?? const M3AlertThemeData();
  }

  @override
  bool updateShouldNotify(M3AlertTheme oldWidget) => data != oldWidget.data;
}
