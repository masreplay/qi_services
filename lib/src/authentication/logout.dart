import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';

Future<void> logout({required WidgetRef ref}) async {
  await ref.read(authenticationProvider.notifier).clear();
  ref.context.router.replace(const LoginRoute());
}
