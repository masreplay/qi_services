import 'package:faker/faker.dart';
import 'package:qi_services/api/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'authentication.dart';

part 'authentication_repository.g.dart';

@riverpod
LoginRepository loginRepository(LoginRepositoryRef ref) {
  return LoginRepository._(ref);
}

class LoginRepository {
  LoginRepository._(this._ref);
  final LoginRepositoryRef _ref;

  Future<LoginResponse> login(LoginRequest body) async {
    await Future.delayed(const Duration(seconds: 2));
    final result = LoginResponse(
      token: faker.guid.guid(),
      phone: body.phone,
    );

    await _ref.read(authenticationProvider.notifier).update((_) => result);

    return result;
  }
}
