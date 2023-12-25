import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qi_services/preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:useful_hook/useful_hook.dart';

part 'settings_provider.freezed.dart';
part 'settings_provider.g.dart';

class _LocalStringJsonConverter extends JsonConverter<Locale, String> {
  const _LocalStringJsonConverter();
  @override
  Locale fromJson(String json) => Locale(json);
  @override
  String toJson(Locale object) => object.toString().split("_").first;
}

class _ThemeModeStringJsonConverter extends JsonConverter<ThemeMode, String> {
  const _ThemeModeStringJsonConverter();
  @override
  ThemeMode fromJson(String json) => switch (json) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system
      };
  @override
  String toJson(ThemeMode object) => object.name;
}

class _ColorStringJsonConverter extends JsonConverter<Color, String> {
  const _ColorStringJsonConverter();
  @override
  Color fromJson(String json) => Color(int.parse(json));
  @override
  String toJson(Color object) => object.value.toString();
}

const Locale? defaultLocale = null;
const ThemeMode defaultThemeMode = ThemeMode.light;
const Color defaultSeedColor = Color(0xffE8341A);

@freezed
class AppSettings with _$AppSettings {
  const AppSettings._();

  @JsonSerializable(
    explicitToJson: true,
    converters: [
      _LocalStringJsonConverter(),
      _ThemeModeStringJsonConverter(),
      _ColorStringJsonConverter(),
    ],
  )
  factory AppSettings({
    @Default(defaultLocale) Locale? locale,
    @Default(defaultThemeMode) ThemeMode themeMode,
    @Default(defaultSeedColor) Color seedColor,
  }) = _AppSettings;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}

@riverpod
class Settings extends _$Settings with ObjectPreferenceProviderMixin {
  @override
  @protected
  String get key => Preferences.settings;

  @override
  AppSettings fromJson(Map<String, dynamic> map) => AppSettings.fromJson(map);

  @override
  Map<String, dynamic> toJson(AppSettings value) => value.toJson();

  @override
  AppSettings build() => firstBuild(AppSettings());

  Future<AppSettings> setThemeMode(ThemeMode themeMode) {
    return updateValue(state.copyWith(themeMode: themeMode));
  }

  Future<AppSettings> setLocale(Locale? locale) {
    return updateValue(state.copyWith(locale: locale));
  }
}
