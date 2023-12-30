import 'dart:async';

import 'package:auto_route/auto_route.dart';
// ignore: depend_on_referenced_packages
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/api_error_handler.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/main/main.dart';
import 'package:qi_services/unimplemented.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

    final services = <LayoutCategory<ServiceData>>[
      LayoutCategory(
        title: l10n.services,
        layout: LayoutViewVariant.list,
        data: [
          ServiceData(
            title: l10n.accountInformation,
            icon: const Icon(Icons.settings_outlined),
            foregroundColor: Colors.white,
            gradient: const LinearGradient(
              colors: [Color(0xff4187BA), Color(0xff1A5582)],
            ),
          ),
          ServiceData(
            title: l10n.moneyTransfer,
            icon: const Icon(DefaultIcons.transfer),
          ),
          ServiceData(
            title: l10n.linkedCards,
            icon: const Icon(Icons.credit_card_outlined),
          ),
          ServiceData(
            title: l10n.updateAccount,
            icon: const Icon(Icons.autorenew_rounded),
          ),
          ServiceData(
            title: l10n.financialTransactions,
            icon: const Icon(Icons.list_outlined),
          ),
          ServiceData(
            title: l10n.updateInformation,
            icon: const Icon(Icons.sync_problem_outlined),
          ),
          ServicesData.getAlRafidainLoans(context: context),
          ServiceData(
            title: l10n.trackRequests,
            icon: const Icon(DefaultIcons.placeholder),
            foregroundColor: Colors.white,
            gradient: const LinearGradient(
              colors: [Color(0xffC06981), Color(0xffF7CBD8)],
            ),
          ),
          ServicesData.getSalafati(context: context),
        ],
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

  final List<LayoutCategory<ServiceData>> services;
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
                    padding: EdgeInsetsDirectional.only(
                      start: index == 0 ? spacing : Insets.xsmall,
                      end: index == data.length - 1 ? spacing : Insets.xsmall,
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
            error: apiErrorHandler(
              orElse: () {
                return Container();
              },
            ),
            loading: () {
              const items = 3;
              return ExpandablePageView.builder(
                controller: controller,
                itemCount: items,
                padEnds: false,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: index == 0 ? spacing : Insets.xsmall,
                      end: index == items - 1 ? spacing : Insets.xsmall,
                    ),
                    child: const AccountTileLoadingState(),
                  );
                },
              );
            },
          ),
          LayoutView(
            services,
            type: LayoutViewVariant.grid,
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.medium,
              vertical: Insets.small,
            ),
            delegate: const LayoutViewDelegate(
              crossAxisSpacing: Insets.xsmall,
              mainAxisSpacing: Insets.xsmall,
            ),
            listTileBuilder: (context, index, item) {
              return ServiceListTile(item, index: index);
            },
            gridTileBuilder: (context, index, item) {
              return ServiceGridTile(
                item,
                showDescription: true,
              );
            },
          ),
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

  final List<LayoutCategory<ServiceData>> services;
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
                        const AccountTileLoadingState(),
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
