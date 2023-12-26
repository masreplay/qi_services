import 'package:qi_services/common_lib.dart';

Future<void> showLoadingBottomSheet({
  required BuildContext context,
  required String? titleText,
}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (context) {
      final l10n = context.l10n;
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;
      final textTheme = theme.textTheme;
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.medium,
          vertical: Insets.extraLarge,
        ),
        child: RowPadded(
          spacing: Insets.medium,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox.square(
              dimension: IconSizes.medium,
              child: CircularProgressIndicator(
                strokeWidth: StrokeWidths.small,
              ),
            ),
            Text(
              titleText ?? l10n.loading,
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    },
  );
}
