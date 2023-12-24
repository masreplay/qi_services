import 'package:qi_services/api/models/login_model.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/main/preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:useful_hook/useful_hook.dart';

part 'authentication_provider.g.dart';

@riverpod
class Authentication extends _$Authentication
    with NullableObjectPreferenceProviderMixin<LoginResponse> {
  @override
  LoginResponse? build() => firstBuild();

  @override
  @protected
  String get key => Preferences.authentication;

  @override
  LoginResponse? fromJson(Map<String, dynamic>? map) {
    return map == null ? null : LoginResponse.fromJson(map);
  }

  @override
  Map<String, dynamic>? toJson(LoginResponse? value) {
    return value?.toJson();
  }
}
