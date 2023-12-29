import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:qi_services/unimplemented.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'accounts_repository.dart';
import 'accounts_tile.dart';

part 'account_page.g.dart';

@riverpod
Future<List<AccountModel>> getAccounts(GetAccountsRef ref) async {
  return ref.read(accountsRepositoryProvider).getAll();
}

class _AccountServiceData {
  const _AccountServiceData({
    required this.label,
    required this.icon,
    required this.foregroundColor,
    this.backgroundColor,
  });

  final String label;
  final IconData icon;
  final Color foregroundColor;
  final Color? backgroundColor;
}

@RoutePage()
class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final provider = getAccountsProvider;
    final state = ref.watch(provider);

    final services = <_AccountServiceData>[
      _AccountServiceData(
        label: l10n.accountInformation,
        icon: Icons.settings_rounded,
        foregroundColor: AppColors.vermilion,
      ),
      _AccountServiceData(
        label: l10n.moneyTransfer,
        icon: Icons.swap_horiz_outlined,
        foregroundColor: AppColors.purple,
      ),
      _AccountServiceData(
        label: l10n.linkedCards,
        icon: Icons.credit_card,
        foregroundColor: AppColors.yellow,
      ),
      _AccountServiceData(
        label: l10n.updateAccount,
        icon: Icons.autorenew_rounded,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.grey,
      ),
      _AccountServiceData(
        label: l10n.financialTransactions,
        icon: Icons.list_outlined,
        foregroundColor: AppColors.green,
      ),
      _AccountServiceData(
        label: l10n.updateInformation,
        icon: Icons.sync_problem_outlined,
        foregroundColor: AppColors.yellow,
      ),
      _AccountServiceData(
        label: l10n.alRafidainLoans,
        icon: DefaultIcons.placeholder,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff34A853),
      ),
      _AccountServiceData(
        label: l10n.trackRequests,
        icon: DefaultIcons.placeholder,
        foregroundColor: AppColors.darkPink,
        backgroundColor: AppColors.pink,
      ),
      _AccountServiceData(
        label: l10n.salafati,
        icon: DefaultIcons.placeholder,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffA85BF5),
      ),
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(provider.future),
        child: ResponsiveLayoutBuilder.when(
          compact: (context, constraints) {
            return _AccountPageCompact(services, state: state);
          },
          medium: (context, constraints) {
            return _AccountPageMedium(services, state: state);
          },
          expanded: (context, constraints) {
            return Container();
          },
        ),
      ),
    );
  }
}

class _AccountPageCompact extends HookWidget {
  const _AccountPageCompact(
    this.services, {
    required this.state,
  });

  final List<_AccountServiceData> services;
  final AsyncValue<List<AccountModel>> state;

  @override
  Widget build(BuildContext context) {
    const spacing = Insets.medium;

    final controller = usePageController(
      viewportFraction: 0.95,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          state.when(
            data: (data) {
              return ExpandablePageView.builder(
                controller: controller,
                itemCount: data.length,
                padEnds: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: spacing,
                    ),
                    child: AccountTile(
                      data[index],
                      onPressed: () {
                        showUnimplementedFeature(context: context);
                      },
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: Colors.red,
              );
            },
            loading: () {
              return Container(
                width: 100,
                height: 100,
                color: Colors.red,
              );
            },
          ),
          // AspectRatio(
          //   aspectRatio: 2 / 1,
          //   child: Container(
          //     color: Colors.red,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _AccountPageMedium extends StatelessWidget {
  const _AccountPageMedium(
    this.services, {
    required this.state,
  });

  final List<_AccountServiceData> services;
  final AsyncValue<List<AccountModel>> state;

  @override
  Widget build(BuildContext context) {
    // https://m3.material.io/foundations/layout/applying-layout/medium#4899a0c6-bc71-4e86-8095-39e5d517db6a
    // margin or spacer
    const spacing = Insets.large;
    const itemsSpacing = Insets.small;
    const verticalPadding = EdgeInsets.symmetric(vertical: Insets.medium);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: spacing),
      child: RowPadded(
        spacing: spacing,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: state.when(
              skipLoadingOnRefresh: false,
              data: (data) {
                return SingleChildScrollView(
                  padding: verticalPadding,
                  child: ColumnPadded(
                    spacing: itemsSpacing,
                    children: [
                      for (final account in data) ...[
                        AccountTile(
                          account,
                          onPressed: () {
                            showUnimplementedFeature(context: context);
                          },
                        ),
                        if (data.last != account)
                          const Divider(
                            height: Widths.xsmall,
                            thickness: Widths.xsmall,
                            indent: spacing,
                            endIndent: spacing,
                          ),
                      ],
                    ],
                  ),
                );
              },
              error: (error, stackTrace) {
                return Container();
              },
              loading: () {
                return SingleChildScrollView(
                  padding: verticalPadding,
                  child: ColumnPadded(
                    spacing: itemsSpacing,
                    children: [
                      for (int i = 0; i < 3; i++)
                        const AccountTileLoadingState()
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(),
              ],
            ),
          ),
        ],
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
