import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:qi_services/src/main/authentication_provider.dart';

/// Logout form app clear cache and go to [LoginPage]
Future<void> logout({required WidgetRef ref}) async {
  return ref.read(authenticationProvider.notifier).clear();
}
