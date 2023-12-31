import 'package:qi_services/common_lib.dart';
import 'package:useful_hook/useful_hook.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.transfer)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ColumnPadded(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
          ],
        ),
      ),
    );
  }
}
