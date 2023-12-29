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

    final accountServices = [
      (
        label: l10n.accountInformation,
        icon: Icons.settings_rounded,
        foregroundColor: AppColors.vermilion,
        backgroundColor: null,
      ),
      (
        label: l10n.moneyTransfer,
        icon: Icons.swap_horiz_outlined,
        foregroundColor: AppColors.purple,
        backgroundColor: null,
      ),
      (
        label: l10n.linkedCards,
        icon: Icons.credit_card,
        foregroundColor: AppColors.yellow,
        backgroundColor: null,
      ),
      (
        label: l10n.updateAccount,
        icon: Icons.autorenew_rounded,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.grey,
      ),
      (
        label: l10n.financialTransactions,
        icon: Icons.list_outlined,
        foregroundColor: AppColors.green,
        backgroundColor: null,
      ),
      (
        label: l10n.updateInformation,
        icon: Icons.sync_problem_outlined,
        foregroundColor: AppColors.yellow,
        backgroundColor: null,
      ),
      (
        label: l10n.alRafidainLoans,
        icon: DefaultIcons.placeholder,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff34A853),
      ),
      (
        label: l10n.trackRequests,
        icon: DefaultIcons.placeholder,
        foregroundColor: AppColors.darkPink,
        backgroundColor: AppColors.pink,
      ),
      (
        label: l10n.salafati,
        icon: DefaultIcons.placeholder,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffA85BF5),
      ),
    ];

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
                childAspectRatio: 1 / 1,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: [
                  for (final service in accountServices)
                    AccountServiceGridTile(
                      title: Text(service.label),
                      backgroundColor: const Color(0xffA85BF5),
                      icon: Icon(
                        service.icon,
                        color: service.foregroundColor,
                      ),
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
