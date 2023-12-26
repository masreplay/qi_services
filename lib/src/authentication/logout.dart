import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/api/models/logout_model.dart';
import 'package:qi_services/router/router_extension.dart';
import 'package:qi_services/src/authentication/authentication.dart';

Future<LogoutResponse> logout({required WidgetRef ref}) async {
  final context = ref.context;
  final response = await ref.read(authenticationRepositoryProvider).logout();
  await ref.read(authenticationProvider.notifier).clear();
  if (!context.mounted) return response;
  context.router.replaceAuthenticatedRoute();
  return response;
}
