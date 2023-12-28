import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/main/services/service_model.dart';
import 'package:qi_services/unimplemented.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    required this.description,
    required this.foregroundColor,
    required this.icon,
    required this.onTap,
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

enum LayoutType {
  list,
  grid,
}

@RoutePage()
class ServicesPage extends HookConsumerWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    const selectedLayout = LayoutType.list;
    final state = ref.watch(getServicesProvider);

    final services = <ServiceData>[
      ...state.maybeWhen(
        data: (data) {
          return [
            for (final service in data) service.toServiceData(context: context),
          ];
        },
        orElse: () => [],
      ),
      ServiceData(
        icon: const Icon(Icons.account_balance),
        title: l10n.serviceCardIssuance,
        description: l10n.serviceCardIssuanceDescription,
        foregroundColor: Colors.white,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff4187BA),
            Color(0xff1A5582),
          ],
        ),
        onTap: () {
          showUnimplementedFeature(context: context);
        },
      ),
      ServiceData(
        icon: const Icon(Icons.card_giftcard),
        title: l10n.serviceSpecialCards,
        description: null,
        foregroundColor: Colors.white,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffF37744),
            Color(0xffF84D59),
          ],
        ),
        onTap: () {
          showUnimplementedFeature(context: context);
        },
      ),
      ServiceData(
        icon: const Icon(Icons.flutter_dash),
        title: l10n.serviceDigitalZone,
        description: null,
        foregroundColor: Colors.white,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff1BCA8E),
            Color(0xff14A0B2),
          ],
        ),
        onTap: () {
          showUnimplementedFeature(context: context);
        },
      ),
      ServiceData(
        icon: const Icon(Icons.flutter_dash),
        title: l10n.serviceInstallments,
        description: null,
        foregroundColor: Colors.white,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff20B5F1),
            Color(0xff1A7ADA),
          ],
        ),
        onTap: () {
          showUnimplementedFeature(context: context);
        },
      ),
      ServiceData(
        icon: const Icon(Icons.flutter_dash),
        title: l10n.serviceQiPlaces,
        description: null,
        foregroundColor: Colors.white,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFDCA0C),
            Color(0xffF9AD1C),
          ],
        ),
        onTap: () {
          showUnimplementedFeature(context: context);
        },
      ),
      ServiceData(
        icon: const Icon(Icons.flutter_dash),
        title: l10n.serviceTasdeed,
        description: null,
        foregroundColor: Colors.white,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff108176),
            Color(0xff18B6A2),
          ],
        ),
        onTap: () {
          showUnimplementedFeature(context: context);
        },
      ),
      ServiceData(
        icon: const Icon(Icons.flutter_dash),
        title: l10n.serviceSelifty,
        description: null,
        foregroundColor: Colors.white,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff5F60FC),
            Color(0xff933BF6),
          ],
        ),
        onTap: () {
          showUnimplementedFeature(context: context);
        },
      ),
      ServiceData(
        icon: const Icon(Icons.flutter_dash),
        title: l10n.serviceAlRafidainLoans,
        description: null,
        foregroundColor: Colors.white,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff2BA045),
            Color(0xff42BE64),
          ],
        ),
        onTap: () {
          showUnimplementedFeature(context: context);
        },
      ),
    ];

    Widget layoutWidget;

    switch (selectedLayout) {
      case LayoutType.list:
        layoutWidget = ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: Insets.medium),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return ServiceListTile(
              services[index],
              index: index,
            );
          },
          separatorBuilder: (context, _) {
            return const SizedBox.square(dimension: Insets.small);
          },
        );
        break;
      case LayoutType.grid:
        layoutWidget = GridView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: Insets.medium,
            horizontal: Insets.medium,
          ),
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: Insets.medium,
            mainAxisSpacing: Insets.medium,
          ),
          itemBuilder: (context, index) {
            return ServiceGridTile(services[index]);
          },
        );
        break;
    }
    return RefreshIndicator(
      onRefresh: () => ref.refresh(getServicesProvider.future),
      child: layoutWidget,
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
      onTap: data.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.medium,
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
                child: Center(
                  child: SizedBox.square(
                    dimension: IconSizes.large,
                    child: data.icon,
                  ),
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
  });

  final ServiceData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    const foregroundColor = Color(0xFFFFFFFF);
    final borderRadius = BorderRadius.circular(24.0);

    return Ink(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: data.gradient,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: data.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: foregroundColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: foregroundColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: SizedBox.square(
                  dimension: IconSizes.extraLarge,
                  child: IconTheme(
                    data: const IconThemeData(
                      color: foregroundColor,
                      size: 36.0,
                    ),
                    child: data.icon,
                  ),
                ),
              ),
            ),
            DefaultTextStyle(
              style: textTheme.titleLarge!.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.bold,
              ),
              child: Text(data.title),
            ),
          ],
        ),
      ),
    );
  }
}
