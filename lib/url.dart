import 'package:auto_route/auto_route.dart';
import 'package:qi_services/common_lib.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String appDeepLinkDomain = "qi.iq";

Future<void> launchDeeplinkOrUrlString({
  required BuildContext context,
  required String url,
}) {
  if (url.contains(appDeepLinkDomain)) {
    final path = Uri.parse(url).path;
    return context.router.pushNamed(path);
  } else {
    return launchUrlString(
      url,
      mode: LaunchMode.platformDefault,
    );
  }
}
