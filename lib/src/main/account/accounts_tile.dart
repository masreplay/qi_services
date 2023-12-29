import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
import 'package:timeago/timeago.dart';

const double creditCardAspectRatio = 1.586;

class AccountTileLoadingState extends HookWidget {
  const AccountTileLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AspectRatio(
      aspectRatio: creditCardAspectRatio,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(
            Radiuses.large,
          ),
        ),
      ),
    );
  }
}

class AccountTile extends HookWidget {
  const AccountTile(
    this.data, {
    super.key,
    this.onPressed,
  });

  final AccountModel data;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final obscure = useState(true);

    // based on brightness
    final backgroundColor = data.map(
      active: (value) => colorScheme.secondaryContainer,
      blocked: (value) => colorScheme.surfaceVariant,
    );

    final foregroundColor = data.map(
      active: (value) => colorScheme.onSecondaryContainer,
      blocked: (value) => colorScheme.onSurfaceVariant,
    );

    final foregroundVariantColor = data.map(
      active: (value) => colorScheme.secondary,
      blocked: (value) => colorScheme.onSurfaceVariant,
    );

    final borderRadius = BorderRadius.circular(Radiuses.large);

    return ColumnPadded(
      spacing: Insets.xsmall,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.small),
          child: data.map(
            active: (value) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.active,
                  style: textTheme.bodyLarge,
                ),
                IconButton.outlined(
                  onPressed: onPressed,
                  icon: const Icon(DefaultIcons.more),
                ),
              ],
            ),
            blocked: (value) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.blocked,
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      value.reason,
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                IconButton.outlined(
                  onPressed: onPressed,
                  icon: const Icon(DefaultIcons.more),
                ),
              ],
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: creditCardAspectRatio,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onPressed,
            child: Ink(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        data.serviceName,
                        style: textTheme.titleMedium?.copyWith(
                          color: foregroundVariantColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  RowPadded(
                    spacing: Insets.xsmall,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.availableBalance,
                              style: textTheme.bodyMedium?.copyWith(
                                color: foregroundColor,
                              ),
                            ),
                            Text(
                              "${data.balance} ${data.currency}",
                              style: textTheme.headlineSmall?.copyWith(
                                color: foregroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton.outlined(
                        onPressed: () {
                          obscure.value = !obscure.value;
                        },
                        color: foregroundColor,
                        icon: obscure.value
                            ? const Icon(DefaultIcons.invisible)
                            : const Icon(DefaultIcons.visible),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Animate(
                        target: obscure.value ? 1 : 0,
                        effects: const [ShakeEffect()],
                        child: Text(
                          obscure.value
                              ? _obscuringText(data.number)
                              : data.number,
                          style: textTheme.bodyMedium?.copyWith(
                            color: foregroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TimeAgo(
                        duration: const Duration(minutes: 1),
                        builder: (context, now) {
                          return Text(
                            format(
                              data.lastUpdate,
                              locale: context.l10n.localeName,
                            ),
                            style: textTheme.bodyMedium?.copyWith(
                              color: foregroundColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _obscuringText(String number) {
    final lastFourDigits = number.substring(number.length - 4);
    return "**** $lastFourDigits";
  }
}
