// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      locale: _$JsonConverterFromJson<String, Locale>(
              json['locale'], const _LocalStringJsonConverter().fromJson) ??
          defaultLocale,
      themeMode: json['themeMode'] == null
          ? defaultThemeMode
          : const _ThemeModeStringJsonConverter()
              .fromJson(json['themeMode'] as String),
      seedColor: json['seedColor'] == null
          ? defaultSeedColor
          : const _ColorStringJsonConverter()
              .fromJson(json['seedColor'] as String),
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'locale': _$JsonConverterToJson<String, Locale>(
          instance.locale, const _LocalStringJsonConverter().toJson),
      'themeMode':
          const _ThemeModeStringJsonConverter().toJson(instance.themeMode),
      'seedColor': const _ColorStringJsonConverter().toJson(instance.seedColor),
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

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsHash() => r'42e6cd4641aebc949800aca2b678ec7422ebf4c7';

/// See also [Settings].
@ProviderFor(Settings)
final settingsProvider =
    AutoDisposeNotifierProvider<Settings, AppSettings>.internal(
  Settings.new,
  name: r'settingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$settingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Settings = AutoDisposeNotifier<AppSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
