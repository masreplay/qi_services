import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_model.g.dart';
part 'forgot_password_model.freezed.dart';

@freezed
class ForgotPasswordRequest with _$ForgotPasswordRequest {
  @JsonSerializable()
  const factory ForgotPasswordRequest({
    required String phone,
  }) = _ForgotPasswordRequest;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}

@freezed
class ForgotPasswordResponse with _$ForgotPasswordResponse {
  @JsonSerializable()
  const factory ForgotPasswordResponse({
    required String token,
  }) = _ForgotPasswordResponse;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}
