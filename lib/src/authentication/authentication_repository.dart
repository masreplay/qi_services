import 'package:faker/faker.dart';
import 'package:qi_services/api/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'authentication.dart';

part 'authentication_repository.g.dart';

@riverpod
AuthenticationRepository authenticationRepository(
  AuthenticationRepositoryRef ref,
) {
  return AuthenticationRepository._(ref);
}

class AuthenticationRepository {
  AuthenticationRepository._(this._ref);
  final AuthenticationRepositoryRef _ref;

  Future<LoginResponse> login(LoginRequest body) async {
    await Future.delayed(const Duration(seconds: 2));

    final result = LoginResponse(
      token: faker.guid.guid(),
      name: "John Doe",
      phone: body.phone,
    );

    await _ref.read(authenticationProvider.notifier).updateValue(result);

    return result;
  }

  Future<ForgotPasswordResponse> forgotPassword(
    ForgotPasswordRequest body,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final result = ForgotPasswordResponse(
      token: faker.guid.guid(),
    );

    return result;
  }

  Future<LogoutResponse> logout() async {
    await Future.delayed(const Duration(seconds: 2));
    return LogoutResponse();
  }
}
