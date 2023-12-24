import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/main/account_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart';
import 'package:useful_hook/useful_hook.dart';

import 'accounts_repository.dart';
import 'time_ago.dart';

part 'account_page.g.dart';

@riverpod
Future<List<AccountModel>> getAccounts(GetAccountsRef ref) async {
  return ref.read(accountsRepositoryProvider).getAll();
}

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final provider = getAccountsProvider;
    final state = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.account),
        actions: [
          IconButton.filled(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(provider.future),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: state.when(
                data: AccountsPageView.new,
                error: (error, stackTrace) => Center(
                  child: Text(context.l10n.defaultErrorMessage),
                ),
                loading: LinearProgressIndicator.new,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverGrid.count(
                crossAxisCount: 3,
                childAspectRatio: 6 / 5,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: [
                  AccountServiceGridTile(
                    title: Text(context.l10n.moneyTransfer),
                    icon: const Icon(
                      Icons.swap_horiz_outlined,
                      color: Color(0xff9D88EB),
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(context.l10n.accountInformation),
                    icon: const Icon(
                      Icons.settings_rounded,
                      color: Color(0xffFA7068),
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(context.l10n.linkedCards),
                    icon: const Icon(
                      Icons.credit_card,
                      color: Color(0xffEECD0A),
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(context.l10n.updateAccount),
                    icon: const Icon(
                      Icons.autorenew_rounded,
                      color: Color(0xff787774),
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(context.l10n.financialTransactions),
                    icon: const Icon(
                      Icons.list_outlined,
                      color: Color(0xff0C9089),
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(context.l10n.updateInformation),
                    icon: const Icon(
                      Icons.sync_problem_outlined,
                      color: Color(0xffEECD0A),
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(context.l10n.alRafidainLoans),
                    icon: const Icon(Icons.flutter_dash),
                    backgroundColor: const Color(0xff34A853),
                    foregroundColor: Colors.white,
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(context.l10n.trackRequests),
                    icon: const Icon(
                      Icons.flutter_dash,
                      color: Color(0xffC06981),
                    ),
                    backgroundColor: const Color(0xffF7CBD8),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(context.l10n.salafati),
                    icon: const Icon(Icons.flutter_dash),
                    backgroundColor: const Color(0xffA85BF5),
                    foregroundColor: Colors.white,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverToBoxAdapter(
                child: AspectRatio(
                  aspectRatio: 11 / 3,
                  child: Placeholder(),
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverToBoxAdapter(
                child: AspectRatio(
                  aspectRatio: 11 / 3,
                  child: Placeholder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountsPageView extends HookWidget {
  const AccountsPageView(
    this.data, {
    super.key,
  });

  final List<AccountModel> data;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 3,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
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
    );
  }
}

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

class AccountServiceGridTile extends StatelessWidget {
  const AccountServiceGridTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Widget title;
  final Widget icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.0);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor = this.backgroundColor ?? colorScheme.surfaceVariant;
    final foregroundColor = this.foregroundColor ?? colorScheme.onSurface;

    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      color: backgroundColor,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          child: IconTheme(
            data: IconThemeData(color: foregroundColor),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 16.0,
                color: foregroundColor,
              ),
              child: ColumnPadded(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: SizedBox.square(
                      dimension: 24.0,
                      child: icon,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: title),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
