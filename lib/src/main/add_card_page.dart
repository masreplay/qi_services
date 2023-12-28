import 'package:auto_route/auto_route.dart';
import 'package:qi_services/common_lib.dart';

@RoutePage()
class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addCard),
      ),
    );
  }
}
