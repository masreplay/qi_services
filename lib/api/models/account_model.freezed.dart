// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'active':
      return AccountModelActive.fromJson(json);
    case 'blocked':
      return AccountModelBlocked.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'AccountModel',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$AccountModel {
  String get number => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  String get balance => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  DateTime get lastUpdate => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate)
        active,
    required TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate, String reason)
        blocked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate)?
        active,
    TResult? Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate, String reason)?
        blocked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate)?
        active,
    TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate, String reason)?
        blocked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountModelActive value) active,
    required TResult Function(AccountModelBlocked value) blocked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountModelActive value)? active,
    TResult? Function(AccountModelBlocked value)? blocked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountModelActive value)? active,
    TResult Function(AccountModelBlocked value)? blocked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountModelCopyWith<AccountModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountModelCopyWith<$Res> {
  factory $AccountModelCopyWith(
          AccountModel value, $Res Function(AccountModel) then) =
      _$AccountModelCopyWithImpl<$Res, AccountModel>;
  @useResult
  $Res call(
      {String number,
      String serviceName,
      String balance,
      String currency,
      DateTime lastUpdate});
}

/// @nodoc
class _$AccountModelCopyWithImpl<$Res, $Val extends AccountModel>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? serviceName = null,
    Object? balance = null,
    Object? currency = null,
    Object? lastUpdate = null,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountModelActiveImplCopyWith<$Res>
    implements $AccountModelCopyWith<$Res> {
  factory _$$AccountModelActiveImplCopyWith(_$AccountModelActiveImpl value,
          $Res Function(_$AccountModelActiveImpl) then) =
      __$$AccountModelActiveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String number,
      String serviceName,
      String balance,
      String currency,
      DateTime lastUpdate});
}

/// @nodoc
class __$$AccountModelActiveImplCopyWithImpl<$Res>
    extends _$AccountModelCopyWithImpl<$Res, _$AccountModelActiveImpl>
    implements _$$AccountModelActiveImplCopyWith<$Res> {
  __$$AccountModelActiveImplCopyWithImpl(_$AccountModelActiveImpl _value,
      $Res Function(_$AccountModelActiveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? serviceName = null,
    Object? balance = null,
    Object? currency = null,
    Object? lastUpdate = null,
  }) {
    return _then(_$AccountModelActiveImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountModelActiveImpl implements AccountModelActive {
  const _$AccountModelActiveImpl(
      {required this.number,
      required this.serviceName,
      required this.balance,
      required this.currency,
      required this.lastUpdate,
      final String? $type})
      : $type = $type ?? 'active';

  factory _$AccountModelActiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountModelActiveImplFromJson(json);

  @override
  final String number;
  @override
  final String serviceName;
  @override
  final String balance;
  @override
  final String currency;
  @override
  final DateTime lastUpdate;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AccountModel.active(number: $number, serviceName: $serviceName, balance: $balance, currency: $currency, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountModelActiveImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, number, serviceName, balance, currency, lastUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountModelActiveImplCopyWith<_$AccountModelActiveImpl> get copyWith =>
      __$$AccountModelActiveImplCopyWithImpl<_$AccountModelActiveImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate)
        active,
    required TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate, String reason)
        blocked,
  }) {
    return active(number, serviceName, balance, currency, lastUpdate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate)?
        active,
    TResult? Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate, String reason)?
        blocked,
  }) {
    return active?.call(number, serviceName, balance, currency, lastUpdate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate)?
        active,
    TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate, String reason)?
        blocked,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(number, serviceName, balance, currency, lastUpdate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountModelActive value) active,
    required TResult Function(AccountModelBlocked value) blocked,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountModelActive value)? active,
    TResult? Function(AccountModelBlocked value)? blocked,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountModelActive value)? active,
    TResult Function(AccountModelBlocked value)? blocked,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountModelActiveImplToJson(
      this,
    );
  }
}

abstract class AccountModelActive implements AccountModel {
  const factory AccountModelActive(
      {required final String number,
      required final String serviceName,
      required final String balance,
      required final String currency,
      required final DateTime lastUpdate}) = _$AccountModelActiveImpl;

  factory AccountModelActive.fromJson(Map<String, dynamic> json) =
      _$AccountModelActiveImpl.fromJson;

  @override
  String get number;
  @override
  String get serviceName;
  @override
  String get balance;
  @override
  String get currency;
  @override
  DateTime get lastUpdate;
  @override
  @JsonKey(ignore: true)
  _$$AccountModelActiveImplCopyWith<_$AccountModelActiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccountModelBlockedImplCopyWith<$Res>
    implements $AccountModelCopyWith<$Res> {
  factory _$$AccountModelBlockedImplCopyWith(_$AccountModelBlockedImpl value,
          $Res Function(_$AccountModelBlockedImpl) then) =
      __$$AccountModelBlockedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String number,
      String serviceName,
      String balance,
      String currency,
      DateTime lastUpdate,
      String reason});
}

/// @nodoc
class __$$AccountModelBlockedImplCopyWithImpl<$Res>
    extends _$AccountModelCopyWithImpl<$Res, _$AccountModelBlockedImpl>
    implements _$$AccountModelBlockedImplCopyWith<$Res> {
  __$$AccountModelBlockedImplCopyWithImpl(_$AccountModelBlockedImpl _value,
      $Res Function(_$AccountModelBlockedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? serviceName = null,
    Object? balance = null,
    Object? currency = null,
    Object? lastUpdate = null,
    Object? reason = null,
  }) {
    return _then(_$AccountModelBlockedImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdate: null == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountModelBlockedImpl implements AccountModelBlocked {
  const _$AccountModelBlockedImpl(
      {required this.number,
      required this.serviceName,
      required this.balance,
      required this.currency,
      required this.lastUpdate,
      required this.reason,
      final String? $type})
      : $type = $type ?? 'blocked';

  factory _$AccountModelBlockedImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountModelBlockedImplFromJson(json);

  @override
  final String number;
  @override
  final String serviceName;
  @override
  final String balance;
  @override
  final String currency;
  @override
  final DateTime lastUpdate;
  @override
  final String reason;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AccountModel.blocked(number: $number, serviceName: $serviceName, balance: $balance, currency: $currency, lastUpdate: $lastUpdate, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountModelBlockedImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, number, serviceName, balance, currency, lastUpdate, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountModelBlockedImplCopyWith<_$AccountModelBlockedImpl> get copyWith =>
      __$$AccountModelBlockedImplCopyWithImpl<_$AccountModelBlockedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate)
        active,
    required TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate, String reason)
        blocked,
  }) {
    return blocked(number, serviceName, balance, currency, lastUpdate, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate)?
        active,
    TResult? Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate, String reason)?
        blocked,
  }) {
    return blocked?.call(
        number, serviceName, balance, currency, lastUpdate, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate)?
        active,
    TResult Function(String number, String serviceName, String balance,
            String currency, DateTime lastUpdate, String reason)?
        blocked,
    required TResult orElse(),
  }) {
    if (blocked != null) {
      return blocked(
          number, serviceName, balance, currency, lastUpdate, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountModelActive value) active,
    required TResult Function(AccountModelBlocked value) blocked,
  }) {
    return blocked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountModelActive value)? active,
    TResult? Function(AccountModelBlocked value)? blocked,
  }) {
    return blocked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountModelActive value)? active,
    TResult Function(AccountModelBlocked value)? blocked,
    required TResult orElse(),
  }) {
    if (blocked != null) {
      return blocked(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountModelBlockedImplToJson(
      this,
    );
  }
}

abstract class AccountModelBlocked implements AccountModel {
  const factory AccountModelBlocked(
      {required final String number,
      required final String serviceName,
      required final String balance,
      required final String currency,
      required final DateTime lastUpdate,
      required final String reason}) = _$AccountModelBlockedImpl;

  factory AccountModelBlocked.fromJson(Map<String, dynamic> json) =
      _$AccountModelBlockedImpl.fromJson;

  @override
  String get number;
  @override
  String get serviceName;
  @override
  String get balance;
  @override
  String get currency;
  @override
  DateTime get lastUpdate;
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$AccountModelBlockedImplCopyWith<_$AccountModelBlockedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
