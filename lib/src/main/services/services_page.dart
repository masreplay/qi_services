import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/main/services/service_model.dart';
import 'package:qi_services/unimplemented.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'layout_view.dart';
import 'services_repository.dart';

part 'services_page.g.dart';

@riverpod
Future<List<ServiceModel>> getServices(GetServicesRef ref) {
  return ref.read(servicesRepositoryProvider).getAll();
}

/// A provider that exposes a [Future] of a [List] of [ServiceModel].
class ServiceData {
  const ServiceData({
    required this.title,
    required this.foregroundColor,
    required this.icon,
    required this.onTap,
    this.description,
    this.gradient,
    this.backgroundColor,
  }) : assert(gradient == null || backgroundColor == null);

  final String title;

  final String? description;

  final Color foregroundColor;

  final LinearGradient? gradient;

  final Color? backgroundColor;

  final Widget icon;

  final VoidCallback onTap;
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

    final seliftyService = ServiceData(
      icon: const Icon(DefaultIcons.placeholder),
      title: l10n.serviceSelifty,
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff5F60FC), Color(0xff933BF6)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );

    final alRafidainLoansService = ServiceData(
      title: l10n.serviceAlRafidainLoans,
      icon: Assets.logo.alrafidainLogo.image(),
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff2BA045), Color(0xff42BE64)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );

    final data = [
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
          seliftyService,
        ],
      ),
      LayoutCategory(
        title: l10n.serviceCategoryTitleOtherServices,
        layout: LayoutViewVariant.list,
        data: [
          qiPlacesService,
          digitalZoneService,
          alRafidainLoansService,
        ],
      ),
    ];

    return RefreshIndicator(
      onRefresh: () => ref.refresh(getServicesProvider.future),
      child: ResponsiveLayoutBuilder.maybeWhen(
        compact: (context, constraints) {
          return LayoutView(
            data,
            type: LayoutViewVariant.mixed,
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.medium,
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
        },
        orElse: (context, constraints) {
          return Container();
        },
      ),
    );
  }
}

class ServiceListTile extends StatelessWidget {
  const ServiceListTile(
    this.data, {
    super.key,
    this.index,
  });

  final ServiceData data;

  final int? index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final description = data.description;

    final index = this.index;

    return InkWell(
      onLongPress: () {
        showServiceModalBottomSheet(
          context: context,
          data: data,
        );
      },
      onTap: data.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.xsmall,
          vertical: Insets.small,
        ),
        child: RowPadded(
          spacing: Insets.medium,
          children: [
            if (index != null)
              Text(
                '${index + 1}',
                style: textTheme.bodyLarge!.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Radiuses.medium),
                gradient: data.gradient,
              ),
              child: IconTheme(
                data: IconThemeData(color: data.foregroundColor),
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: data.icon,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge!.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (description != null)
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceGridTile extends StatelessWidget {
  const ServiceGridTile(
    this.data, {
    super.key,
    this.showDescription = false,
  });

  final ServiceData data;

  final bool showDescription;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final foregroundColor = data.foregroundColor;
    final borderRadius = BorderRadius.circular(Radiuses.large);

    final description = data.description;

    return InkWell(
      onLongPress: () {
        showServiceModalBottomSheet(
          context: context,
          data: data,
        );
      },
      onTap: data.onTap,
      child: Padding(
        padding: const EdgeInsets.all(Insets.xsmall),
        child: ColumnPadded(
          spacing: Insets.xsmall,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: data.gradient,
                ),
                child: IconTheme(
                  data: IconThemeData(color: foregroundColor),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: FittedBox(child: data.icon),
                  ),
                ),
              ),
            ),
            Text(
              data.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            if (showDescription && description != null)
              Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void showServiceModalBottomSheet({
  required BuildContext context,
  required ServiceData data,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      final description = data.description;

      return Padding(
        padding: const EdgeInsets.all(Insets.medium),
        child: ColumnPadded(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(data.title),
              subtitle: description == null ? null : Text(description),
              leading: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Radiuses.large),
                    gradient: data.gradient,
                  ),
                  child: IconTheme(
                    data: IconThemeData(color: data.foregroundColor),
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: FittedBox(child: data.icon),
                    ),
                  ),
                ),
              ),
            ),
            FilledButton.icon(
              onPressed: () {
                context.router.pop();
                data.onTap();
              },
              icon: const Icon(Icons.open_in_new),
              label: Text(context.l10n.open),
            ),
          ],
        ),
      );
    },
  );
}
