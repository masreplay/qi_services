// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountModelActiveImpl _$$AccountModelActiveImplFromJson(
        Map<String, dynamic> json) =>
    _$AccountModelActiveImpl(
      number: json['number'] as String,
      serviceName: json['serviceName'] as String,
      balance: json['balance'] as String,
      currency: json['currency'] as String,
      lastUpdate: DateTime.parse(json['lastUpdate'] as String),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AccountModelActiveImplToJson(
        _$AccountModelActiveImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'serviceName': instance.serviceName,
      'balance': instance.balance,
      'currency': instance.currency,
      'lastUpdate': instance.lastUpdate.toIso8601String(),
      'type': instance.$type,
    };

_$AccountModelBlockedImpl _$$AccountModelBlockedImplFromJson(
        Map<String, dynamic> json) =>
    _$AccountModelBlockedImpl(
      number: json['number'] as String,
      serviceName: json['serviceName'] as String,
      balance: json['balance'] as String,
      currency: json['currency'] as String,
      lastUpdate: DateTime.parse(json['lastUpdate'] as String),
      reason: json['reason'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AccountModelBlockedImplToJson(
        _$AccountModelBlockedImpl instance) =>
    <String, dynamic>{
      'number': instance.number,
      'serviceName': instance.serviceName,
      'balance': instance.balance,
      'currency': instance.currency,
      'lastUpdate': instance.lastUpdate.toIso8601String(),
      'reason': instance.reason,
      'type': instance.$type,
    };
