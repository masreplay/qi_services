import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/unimplemented.dart';

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
class ServicesPage extends HookWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;


    final selectedLayout = useState(LayoutType.list);

    final services = <ServiceData>[
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

    switch (selectedLayout.value) {
      case LayoutType.list:
        layoutWidget = ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: Insets.medium),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return ServiceListTile(service: service);
          },
          separatorBuilder: (context, _) {
            return const SizedBox.square(dimension: Insets.large);
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
            final service = services[index];
            return ServiceGridTile(service: service);
          },
        );
        break;
    }
    return Column(
      children: [
        if (kDebugMode)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
              child: RowPadded(
                children: [
                  for (final layout in LayoutType.values)
                    ChoiceChip(
                      label: Text(layout.name),
                      selected: selectedLayout.value == layout,
                      onSelected: (selected) {
                        if (selected) selectedLayout.value = layout;
                      },
                    )
                ],
              ),
            ),
          ),
        Expanded(
          child: layoutWidget.animate().fadeIn(),
        ),
      ],
    );
  }
}

class ServiceListTile extends StatelessWidget {
  const ServiceListTile({
    super.key,
    required this.service,
  });

  final ServiceData service;

  @override
  Widget build(BuildContext context) {
    final description = service.description;

    return ListTile(
      leading: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radiuses.medium),
            gradient: service.gradient,
          ),
          child: IconTheme(
            data: IconThemeData(color: service.foregroundColor),
            child: Center(
              child: SizedBox.square(
                dimension: IconSizes.medium,
                child: service.icon,
              ),
            ),
          ),
        ),
      ),
      title: Text(service.title),
      subtitle: description == null ? null : Text(description),
      onTap: service.onTap,
    );
  }
}

class ServiceGridTile extends StatelessWidget {
  const ServiceGridTile({
    super.key,
    required this.service,
  });

  final ServiceData service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    const foregroundColor = Color(0xFFFFFFFF);
    final borderRadius = BorderRadius.circular(24.0);

    //   return InkWell(
    //     borderRadius: borderRadius,
    //     onTap: onTap,
    //     child: Ink(
    //       padding: const EdgeInsets.all(8.0),
    //       decoration: BoxDecoration(
    //         borderRadius: borderRadius,
    //         gradient: LinearGradient(
    //           begin: Alignment.topCenter,
    //           end: Alignment.bottomCenter,
    //           colors: gradient,
    //         ),
    //       ),
    //       child: ColumnPadded(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             padding: const EdgeInsets.all(8.0),
    //             decoration: BoxDecoration(
    //               color: foregroundColor.withOpacity(0.1),
    //               shape: BoxShape.circle,
    //             ),
    //             child: Container(
    //               padding: const EdgeInsets.all(12.0),
    //               decoration: BoxDecoration(
    //                 color: foregroundColor.withOpacity(0.1),
    //                 shape: BoxShape.circle,
    //               ),
    //               child: SizedBox.square(
    //                 dimension: IconSizes.extraLarge,
    //                 child: IconTheme(
    //                   data: const IconThemeData(
    //                     color: foregroundColor,
    //                     size: 36.0,
    //                   ),
    //                   child: icon,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           DefaultTextStyle(
    //             style: textTheme.titleLarge!.copyWith(
    //               color: foregroundColor,
    //               fontWeight: FontWeight.bold,
    //             ),
    //             child: title,
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: service.gradient,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: service.onTap,
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
                      child: service.icon,
                    ),
                  ),
                ),
              ),
              DefaultTextStyle(
                style: textTheme.titleLarge!.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(service.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
