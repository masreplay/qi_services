import 'package:auto_route/auto_route.dart';
import 'package:qi_services/common_lib.dart';

/// Referring to the scaffold as adaptive instead of responsive,

class ServiceData {
  const ServiceData({
    required this.title,
    required this.icon,
    this.foregroundColor,
    this.onTap,
    this.description,
    this.gradient,
    this.backgroundColor,
  }) : assert(
          gradient == null || backgroundColor == null,
          'Cannot provide both a gradient and a backgroundColor\n'
          'To have a solid color please provide a backgroundColor',
        );

  final String title;

  final String? description;

  final Color? foregroundColor;

  final LinearGradient? gradient;

  final Color? backgroundColor;

  final Widget icon;

  final VoidCallback? onTap;
}

class ServiceListTile extends StatelessWidget {
  const ServiceListTile(
    this.data, {
    super.key,
    this.index,
  });

  final ServiceData data;

  final int? index;

  @override
  Widget build(BuildContext context) {
    final index = this.index;
    final description = data.description;
    final title = data.title;
    final icon = data.icon;
    final onTap = data.onTap;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final gradient = data.gradient;
    final backgroundColor = data.backgroundColor ?? colorScheme.secondary;
    final foregroundColor = data.foregroundColor ?? colorScheme.onSecondary;

    return InkWell(
      onLongPress: () {
        showServiceModalBottomSheet(
          context: context,
          data: data,
        );
      },
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.xsmall,
          vertical: Insets.small,
        ),
        child: RowPadded(
          spacing: Insets.medium,
          children: [
            if (index != null)
              Text(
                '${index + 1}',
                style: textTheme.bodyLarge!.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Radiuses.medium),
                gradient: gradient,
                color: backgroundColor,
              ),
              child: IconTheme(
                data: IconThemeData(color: foregroundColor),
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: icon,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge!.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (description != null)
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceGridTile extends StatelessWidget {
  const ServiceGridTile(
    this.data, {
    super.key,
    this.showDescription = false,
  });

  final ServiceData data;

  final bool showDescription;

  @override
  Widget build(BuildContext context) {
    final description = data.description;
    final title = data.title;
    final icon = data.icon;
    final onTap = data.onTap;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final gradient = data.gradient;
    final backgroundColor = data.backgroundColor ?? colorScheme.secondary;
    final foregroundColor = data.foregroundColor ?? colorScheme.onSecondary;

    final borderRadius = BorderRadius.circular(Radiuses.large);

    return InkWell(
      onLongPress: () {
        showServiceModalBottomSheet(
          context: context,
          data: data,
        );
      },
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(Insets.xsmall),
        child: ColumnPadded(
          spacing: Insets.xsmall,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: gradient,
                  color: backgroundColor,
                ),
                child: IconTheme(
                  data: IconThemeData(color: foregroundColor),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: FittedBox(child: icon),
                  ),
                ),
              ),
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            if (showDescription && description != null)
              Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void showServiceModalBottomSheet({
  required BuildContext context,
  required ServiceData data,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      final description = data.description;

      return Padding(
        padding: const EdgeInsets.all(Insets.medium),
        child: ColumnPadded(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(data.title),
              subtitle: description == null ? null : Text(description),
              leading: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Radiuses.large),
                    gradient: data.gradient,
                  ),
                  child: IconTheme(
                    data: IconThemeData(color: data.foregroundColor),
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: FittedBox(child: data.icon),
                    ),
                  ),
                ),
              ),
            ),
            FilledButton.icon(
              onPressed: () {
                context.router.pop();
                data.onTap?.call();
              },
              icon: const Icon(Icons.open_in_new),
              label: Text(context.l10n.open),
            ),
          ],
        ),
      );
    },
  );
}
