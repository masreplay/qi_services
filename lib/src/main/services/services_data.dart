import 'package:qi_services/common_lib.dart';
import 'package:qi_services/unimplemented.dart';

import 'services.dart';

abstract final class ServicesData {
  static ServiceData getAlRafidainLoans({
    required BuildContext context,
  }) {
    return ServiceData(
      title: context.l10n.serviceAlRafidainLoans,
      icon: Assets.logo.alrafidainLogo.image(),
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff2BA045), Color(0xff42BE64)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );
  }

  static ServiceData getSalafati({
    required BuildContext context,
  }) {
    return ServiceData(
      icon: const Icon(DefaultIcons.placeholder),
      title: context.l10n.serviceSalafati,
      foregroundColor: Colors.white,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff5F60FC), Color(0xff933BF6)],
      ),
      onTap: () => showUnimplementedFeature(context: context),
    );
  }
}
