import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/unimplemented.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'layout_view.dart';
import 'service_tile_widget.dart';
import 'services_data.dart';
import 'services_repository.dart';

part 'services_page.g.dart';

@riverpod
Future<List<ServiceModel>> getServices(GetServicesRef ref) {
  return ref.read(servicesRepositoryProvider).getAll();
}

@RoutePage()
class ServicesPage extends HookConsumerWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getServicesProvider);

    final l10n = context.l10n;

    final cardIssuanceService = ServiceData(
      icon: const Icon(Icons.account_balance),
      title: l10n.serviceCardIssuance,
      description: l10n.serviceCardIssuanceDescription,
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff4187BA), Color(0xff1A5582)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );

    final specialCardsService = ServiceData(
      icon: const Icon(Icons.card_giftcard),
      title: l10n.serviceSpecialCards,
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xffF37744), Color(0xffF84D59)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );

    final digitalZoneService = ServiceData(
      icon: const Icon(DefaultIcons.placeholder),
      title: l10n.serviceDigitalZone,
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff1BCA8E), Color(0xff14A0B2)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );

    final aksatiService = ServiceData(
      icon: Assets.logo.aksatiLogo.image(),
      title: l10n.serviceAksati,
      description: l10n.serviceAksatiDescription,
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff20B5F1), Color(0xff1A7ADA)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );

    final qiPlacesService = ServiceData(
      icon: const Icon(DefaultIcons.placeholder),
      title: l10n.serviceQiPlaces,
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xffFDCA0C), Color(0xffF9AD1C)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );

    final tasdeedService = ServiceData(
      icon: const Icon(DefaultIcons.placeholder),
      title: l10n.serviceTasdeed,
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff108176), Color(0xff18B6A2)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );

    final services = <LayoutCategory<ServiceData>>[
      LayoutCategory(
        title: l10n.serviceCategoryTitleNewest,
        layout: LayoutViewVariant.list,
        data: state.maybeWhen(
          orElse: () => <ServiceData>[],
          data: (data) {
            return data.map((e) => e.toServiceData(context: context)).toList();
          },
        ),
      ),
      LayoutCategory(
        title: l10n.serviceCategoryTitleMyCardServices,
        layout: LayoutViewVariant.list,
        data: [
          cardIssuanceService,
          specialCardsService,
        ],
      ),
      LayoutCategory(
        title: l10n.serviceCategoryTitleInstallmentServices,
        layout: LayoutViewVariant.grid,
        data: [
          aksatiService,
          tasdeedService,
          ServicesData.getSalafati(context: context),
        ],
      ),
      LayoutCategory(
        title: l10n.serviceCategoryTitleOtherServices,
        layout: LayoutViewVariant.list,
        data: [
          qiPlacesService,
          digitalZoneService,
          ServicesData.getAlRafidainLoans(context: context),
        ],
      ),
    ];

    return RefreshIndicator(
      onRefresh: () => ref.refresh(getServicesProvider.future),
      child: SingleChildScrollView(
        child: Responsive.when(
          context: context,
          compact: () {
            return _ServicesPageCompact(services);
          },
          medium: () {
            return _ServicesPageMedium(services);
          },
          expanded: () {
            return _ServicesPageExpanded(services);
          },
        ),
      ),
    );
  }
}

class _ServicesPageCompact extends StatelessWidget {
  const _ServicesPageCompact(this.services);

  final List<LayoutCategory<ServiceData>> services;

  @override
  Widget build(BuildContext context) {
    return LayoutView(
      services,
      type: LayoutViewVariant.list,
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
    );
  }
}

class _ServicesPageMedium extends StatelessWidget {
  const _ServicesPageMedium(this.services);

  final List<LayoutCategory<ServiceData>> services;

  @override
  Widget build(BuildContext context) {
    return LayoutView(
      services,
      type: LayoutViewVariant.grid,
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.large,
        vertical: Insets.small,
      ),
      delegate: const LayoutViewDelegate(
        crossAxisCount: 4,
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
    );
  }
}

class _ServicesPageExpanded extends StatelessWidget {
  const _ServicesPageExpanded(this.services);

  final List<LayoutCategory<ServiceData>> services;

  @override
  Widget build(BuildContext context) {
    return LayoutView(
      services,
      type: LayoutViewVariant.mixed,
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.large,
        vertical: Insets.small,
      ),
      delegate: const LayoutViewDelegate(
        crossAxisCount: 5,
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
    );
  }
}
