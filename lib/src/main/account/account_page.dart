import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'accounts_repository.dart';
import 'accounts_tile.dart';

part 'account_page.g.dart';

@riverpod
Future<List<AccountModel>> getAccounts(GetAccountsRef ref) async {
  return ref.read(accountsRepositoryProvider).getAll();
}

@RoutePage()
class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final provider = getAccountsProvider;
    final state = ref.watch(provider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(provider.future),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: state.when(
                data: AccountsPageView.new,
                error: (error, stackTrace) => Center(
                  child: Text(l10n.defaultErrorMessage),
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
                    title: Text(l10n.moneyTransfer),
                    icon: const Icon(
                      Icons.swap_horiz_outlined,
                      color: AppColors.purple,
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(l10n.accountInformation),
                    icon: const Icon(
                      Icons.settings_rounded,
                      color: AppColors.vermilion,
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(l10n.linkedCards),
                    icon: const Icon(
                      Icons.credit_card,
                      color: AppColors.yellow,
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(l10n.updateAccount),
                    icon: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey,
                      ),
                      child: const Icon(
                        Icons.autorenew_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(l10n.financialTransactions),
                    icon: const Icon(
                      Icons.list_outlined,
                      color: AppColors.green,
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(l10n.updateInformation),
                    icon: const Icon(
                      Icons.sync_problem_outlined,
                      color: AppColors.yellow,
                    ),
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(l10n.alRafidainLoans),
                    icon: const Icon(DefaultIcons.placeholder),
                    backgroundColor: const Color(0xff34A853),
                    foregroundColor: Colors.white,
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(l10n.trackRequests),
                    icon: const Icon(
                      DefaultIcons.placeholder,
                      color: AppColors.darkPink,
                    ),
                    backgroundColor: AppColors.pink,
                    onTap: () {},
                  ),
                  AccountServiceGridTile(
                    title: Text(l10n.salafati),
                    icon: const Icon(DefaultIcons.placeholder),
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
    final textTheme = theme.textTheme;

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
            // vertical: 16.0,
          ),
          child: IconTheme(
            data: IconThemeData(color: foregroundColor),
            child: DefaultTextStyle(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(
                color: foregroundColor,
              ),
              child: ColumnPadded(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: SizedBox.square(
                      dimension: IconSizes.medium,
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
