import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
import 'package:timeago/timeago.dart';

class AccountsPageView extends HookWidget {
  const AccountsPageView(this.data, {super.key});

  final List<AccountModel> data;

  @override
  Widget build(BuildContext context) {
    final index = useState<int>(0);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ColumnPadded(
      spacing: 2.0,
      children: [
        AspectRatio(
          aspectRatio: 5 / 3,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            onPageChanged: index.update,
            itemBuilder: (context, index) {
              final account = data[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AccountGridTile(
                  account: account,
                  onTap: () {},
                ),
              );
            },
          ),
        ),
        // indicator
        RowPadded(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < data.length; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: index.value == i
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

// TODO: return end with the start of the [when] or switch statement
class AccountGridTile extends HookWidget {
  const AccountGridTile({
    super.key,
    required this.account,
    required this.onTap,
  });

  final AccountModel account;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final titleMedium = textTheme.titleMedium?.copyWith(
      color: Colors.white,
    );
    final titleLarge = textTheme.titleLarge?.copyWith(
      color: Colors.white,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: account.mapOrNull(
            blocked: (value) => Colors.grey,
          ),
          gradient: account.mapOrNull(
            active: (value) => const LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [Color(0xff03BCFE), Color(0xff1D8EE3)],
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.accountNumber,
                        style: titleMedium,
                      ),
                      Text(
                        account.number,
                        style: titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.serviceName,
                        style: titleMedium,
                      ),
                      Text(
                        account.serviceName,
                        style: titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.availableBalance,
                        style: titleMedium,
                      ),
                      Text(
                        "${account.balance} ${account.currency}",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffFEBF0C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                account.map(
                  active: (value) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: RowPadded(
                        children: [
                          Text(
                            l10n.active,
                            style: titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 16.0,
                            height: 16.0,
                            decoration: const BoxDecoration(
                              color: Color(0xff47EF1F),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  blocked: (value) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: RowPadded(
                        children: [
                          Text(
                            l10n.blocked,
                            style: titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Icon(
                            Icons.lock_outline_rounded,
                            size: 18.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                TimeAgo(
                  duration: const Duration(minutes: 1),
                  builder: (context, now) {
                    return Text(
                      format(account.lastUpdate),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
