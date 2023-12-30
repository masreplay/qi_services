import 'package:auto_route/auto_route.dart';
import 'package:qi_services/common_lib.dart';

@RoutePage()
class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive.when(
        context: context,
        compact: _TransferPageCompact.new,
        medium: _TransferPageOrElse.new,
        expanded: _TransferPageOrElse.new,
      ),
    );
  }
}

class _TransferPageCompact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(Insets.medium),
      child: ColumnPadded(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Insets.medium,
        children: [
          const AspectRatio(
            aspectRatio: 16 / 9,
            child: Placeholder(),
          ),
          Text(
            l10n.transferServiceTitle,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.primary,
            ),
          ),
          Text(
            l10n.transferServiceDescription,
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(DefaultIcons.transfer),
            label: Text(l10n.moneyTransfer),
          ),
        ],
      ),
    );
  }
}

class _TransferPageOrElse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    const pane1 = AspectRatio(
      aspectRatio: 9 / 16,
      child: Placeholder(),
    );

    final pane2 = ColumnPadded(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Insets.medium,
      children: [
        Text(
          l10n.transferServiceTitle,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        Text(
          l10n.transferServiceDescription,
          style: textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(DefaultIcons.transfer),
          label: Text(l10n.moneyTransfer),
        ),
      ],
    );

    const spacing = Insets.large;
    return Padding(
      padding: const EdgeInsets.all(spacing),
      child: RowPadded(
        spacing: spacing,
        children: [
          const Expanded(
            flex: 2,
            child: pane1,
          ),
          Expanded(
            flex: 3,
            child: pane2,
          ),
        ],
      ),
    );
  }
}
