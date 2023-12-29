// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceModelImpl _$$ServiceModelImplFromJson(Map<String, dynamic> json) =>
    _$ServiceModelImpl(
      titles: Map<String, String>.from(json['titles'] as Map),
      descriptions: Map<String, String>.from(json['descriptions'] as Map),
      image: json['image'] as String,
      url: json['url'] as String,
      urlLaunchMode: const _LaunchModeJsonConverter()
          .fromJson(json['urlLaunchMode'] as String),
      backgroundColor: _$JsonConverterFromJson<String, Color>(
          json['backgroundColor'], const _ColorJsonConverter().fromJson),
      foregroundColor: const _ColorJsonConverter()
          .fromJson(json['foregroundColor'] as String),
      gradientColors: (json['gradientColors'] as List<dynamic>?)
          ?.map((e) => const _ColorJsonConverter().fromJson(e as String))
          .toList(),
      gradientBegin: _$JsonConverterFromJson<String, Alignment>(
          json['gradientBegin'], const _AlignmentJsonConverter().fromJson),
      gradientEnd: _$JsonConverterFromJson<String, Alignment>(
          json['gradientEnd'], const _AlignmentJsonConverter().fromJson),
    );

Map<String, dynamic> _$$ServiceModelImplToJson(_$ServiceModelImpl instance) =>
    <String, dynamic>{
      'titles': instance.titles,
      'descriptions': instance.descriptions,
      'image': instance.image,
      'url': instance.url,
      'urlLaunchMode':
          const _LaunchModeJsonConverter().toJson(instance.urlLaunchMode),
      'backgroundColor': _$JsonConverterToJson<String, Color>(
          instance.backgroundColor, const _ColorJsonConverter().toJson),
      'foregroundColor':
          const _ColorJsonConverter().toJson(instance.foregroundColor),
      'gradientColors': instance.gradientColors
          ?.map(const _ColorJsonConverter().toJson)
          .toList(),
      'gradientBegin': _$JsonConverterToJson<String, Alignment>(
          instance.gradientBegin, const _AlignmentJsonConverter().toJson),
      'gradientEnd': _$JsonConverterToJson<String, Alignment>(
          instance.gradientEnd, const _AlignmentJsonConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
