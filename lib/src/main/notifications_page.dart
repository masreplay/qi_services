import 'package:auto_route/auto_route.dart';
import 'package:qi_services/common_lib.dart';

@RoutePage()
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.notifications),
      ),
    );
  }
}
