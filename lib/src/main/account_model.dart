import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

mixin _AccountModelMixin {
  String get number;
  String get serviceName;
  String get balance;
  String get currency;
  DateTime get lastUpdate;
}

@Freezed(
  unionKey: "type",
  // unionValueCase: FreezedUnionCase.snake,
)
class AccountModel with _$AccountModel, _AccountModelMixin {
  /// Never extend a freezed class with a mixin using [With] annotation.
  // @With<_AccountModelMixin>()
  const factory AccountModel.active({
    required String number,
    required String serviceName,
    required String balance,
    required String currency,
    required DateTime lastUpdate,
  }) = AccountModelActive;

  const factory AccountModel.blocked({
    required String number,
    required String serviceName,
    required String balance,
    required String currency,
    required DateTime lastUpdate,
    required String reason,
  }) = AccountModelBlocked;

  // TODO: add other types

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}
