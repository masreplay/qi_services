import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_model.freezed.dart';
part 'logout_model.g.dart';

@freezed
class LogoutResponse with _$LogoutResponse {
  factory LogoutResponse() = _LogoutResponse;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);
}
