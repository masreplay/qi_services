import 'package:qi_services/common_lib.dart';

void showUnimplementedFeature({
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(context.l10n.unimplementedFeature),
    ),
  );
}
