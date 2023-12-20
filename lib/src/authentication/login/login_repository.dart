import 'package:qi_services/api/api.dart';

class LoginRepository {
  // Simple singleton, it's better to use riverpod to manage dependencies
  const LoginRepository._internal();

  static const LoginRepository _instance = LoginRepository._internal();

  static LoginRepository get instance => _instance;

  Future<LoginResponse> login(LoginRequest body) async {
    await Future.delayed(const Duration(seconds: 2));
    return const LoginResponse(token: 'token');
  }
}
