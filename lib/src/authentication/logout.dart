import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/router/router_extension.dart';
import 'package:qi_services/src/authentication/authentication.dart';

Future<void> logout({required WidgetRef ref}) async {
  final context = ref.context;
  await ref.read(authenticationProvider.notifier).clear();
  context.router.replaceAuthenticatedRoute();
}
