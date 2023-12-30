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
        title: l10n.serviceCategoryTitleAccountServices,
        layout: LayoutViewVariant.grid,
        data: [
          ServiceData(
            title: l10n.accountInformation,
            description: l10n.accountInformationDescription,
            icon: const Icon(Icons.settings_outlined),
          ),
          ServiceData(
            title: l10n.updateAccount,
            description: l10n.updateAccountDescription,
            icon: const Icon(Icons.autorenew_rounded),
          ),
          ServiceData(
            title: l10n.updateInformation,
            icon: const Icon(Icons.sync_problem_outlined),
          ),
        ],
      ),
      LayoutCategory(
        title: l10n.serviceCategoryTitleInstallmentServices,
        layout: LayoutViewVariant.grid,
        data: [
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
      LayoutCategory(
        title: l10n.serviceCategoryTitleFinancialServices,
        layout: LayoutViewVariant.list,
        data: [
          ServiceData(
            title: l10n.moneyTransfer,
            icon: const Icon(DefaultIcons.transfer),
          ),
          ServiceData(
            title: l10n.linkedCards,
            icon: const Icon(Icons.credit_card_outlined),
          ),
          ServiceData(
            title: l10n.financialTransactions,
            icon: const Icon(Icons.list_outlined),
          ),
        ],
      ),
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(provider.future),
        child: ResponsiveLayoutBuilder.when(
          compact: (context, size) {
            return _AccountPageCompact(services, state: state);
          },
          medium: (context, size) {
            return _AccountPageMedium(services, state: state);
          },
          expanded: (context, size) {
            return _AccountPageExpanded(services, state: state);
          },
        ),
      ),
    );
  }
}

// TODO: implement this from api later
class AdvertisementPlaceholder extends StatelessWidget {
  const AdvertisementPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 4 / 1,
        child: Assets.logo.digitalZoneAd.image(
          fit: BoxFit.cover,
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
                // TODO: implement this from api later
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
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing,
              vertical: Insets.small,
            ),
            child: AdvertisementPlaceholder(),
          ),
          LayoutView(
            services,
            type: LayoutViewVariant.list,
            padding: const EdgeInsets.symmetric(
              horizontal: spacing,
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

    final pane1 = state.when(
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
      error: apiErrorHandler(
        orElse: () {
          // TODO: implement this from api later
          return Container();
        },
      ),
      loading: () {
        return ListView.separated(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const AccountTileLoadingState();
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: spacing,
              thickness: Widths.xsmall,
              indent: spacing,
              endIndent: spacing,
            );
          },
        );
      },
    );
    final pane2 = CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: AdvertisementPlaceholder(),
        ),
        SliverToBoxAdapter(
          child: LayoutView(
            services,
            type: LayoutViewVariant.list,
            padding: const EdgeInsets.symmetric(),
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
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: spacing),
      child: RowPadded(
        spacing: spacing,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Also works with foldable phone
          Expanded(
            flex: 3,
            child: pane1,
          ),
          Expanded(
            flex: 2,
            child: pane2,
          ),
        ],
      ),
    );
  }
}

class _AccountPageExpanded extends StatelessWidget {
  const _AccountPageExpanded(
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

    final pane1 = state.when(
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
      error: apiErrorHandler(
        orElse: () {
          // TODO: implement this from api later
          return Container();
        },
      ),
      loading: () {
        return ListView.separated(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const AccountTileLoadingState();
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: spacing,
              thickness: Widths.xsmall,
              indent: spacing,
              endIndent: spacing,
            );
          },
        );
      },
    );
    final pane2 = CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: AdvertisementPlaceholder(),
        ),
        SliverToBoxAdapter(
          child: LayoutView(
            services,
            type: LayoutViewVariant.mixed,
            padding: const EdgeInsets.symmetric(),
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
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: spacing),
      child: RowPadded(
        spacing: spacing,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Also works with foldable phone
          Expanded(
            flex: 2,
            child: pane1,
          ),
          Expanded(
            flex: 2,
            child: pane2,
          ),
        ],
      ),
    );
  }
}
