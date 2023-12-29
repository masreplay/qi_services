// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) {
  return _ServiceModel.fromJson(json);
}

/// @nodoc
mixin _$ServiceModel {
// map of language code to title
  Map<String, String> get titles => throw _privateConstructorUsedError;
  Map<String, String> get descriptions =>
      throw _privateConstructorUsedError; // SVG or PNG
  String get image => throw _privateConstructorUsedError; // Deeplink or link
  String get url => throw _privateConstructorUsedError;
  LaunchMode get urlLaunchMode => throw _privateConstructorUsedError; // colors
  Color? get backgroundColor => throw _privateConstructorUsedError;
  Color get foregroundColor => throw _privateConstructorUsedError; // gradient
  List<Color>? get gradientColors => throw _privateConstructorUsedError;
  Alignment? get gradientBegin => throw _privateConstructorUsedError;
  Alignment? get gradientEnd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ServiceModelCopyWith<ServiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceModelCopyWith<$Res> {
  factory $ServiceModelCopyWith(
          ServiceModel value, $Res Function(ServiceModel) then) =
      _$ServiceModelCopyWithImpl<$Res, ServiceModel>;
  @useResult
  $Res call(
      {Map<String, String> titles,
      Map<String, String> descriptions,
      String image,
      String url,
      LaunchMode urlLaunchMode,
      Color? backgroundColor,
      Color foregroundColor,
      List<Color>? gradientColors,
      Alignment? gradientBegin,
      Alignment? gradientEnd});
}

/// @nodoc
class _$ServiceModelCopyWithImpl<$Res, $Val extends ServiceModel>
    implements $ServiceModelCopyWith<$Res> {
  _$ServiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titles = null,
    Object? descriptions = null,
    Object? image = null,
    Object? url = null,
    Object? urlLaunchMode = null,
    Object? backgroundColor = freezed,
    Object? foregroundColor = null,
    Object? gradientColors = freezed,
    Object? gradientBegin = freezed,
    Object? gradientEnd = freezed,
  }) {
    return _then(_value.copyWith(
      titles: null == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      descriptions: null == descriptions
          ? _value.descriptions
          : descriptions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlLaunchMode: null == urlLaunchMode
          ? _value.urlLaunchMode
          : urlLaunchMode // ignore: cast_nullable_to_non_nullable
              as LaunchMode,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      foregroundColor: null == foregroundColor
          ? _value.foregroundColor
          : foregroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      gradientColors: freezed == gradientColors
          ? _value.gradientColors
          : gradientColors // ignore: cast_nullable_to_non_nullable
              as List<Color>?,
      gradientBegin: freezed == gradientBegin
          ? _value.gradientBegin
          : gradientBegin // ignore: cast_nullable_to_non_nullable
              as Alignment?,
      gradientEnd: freezed == gradientEnd
          ? _value.gradientEnd
          : gradientEnd // ignore: cast_nullable_to_non_nullable
              as Alignment?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceModelImplCopyWith<$Res>
    implements $ServiceModelCopyWith<$Res> {
  factory _$$ServiceModelImplCopyWith(
          _$ServiceModelImpl value, $Res Function(_$ServiceModelImpl) then) =
      __$$ServiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, String> titles,
      Map<String, String> descriptions,
      String image,
      String url,
      LaunchMode urlLaunchMode,
      Color? backgroundColor,
      Color foregroundColor,
      List<Color>? gradientColors,
      Alignment? gradientBegin,
      Alignment? gradientEnd});
}

/// @nodoc
class __$$ServiceModelImplCopyWithImpl<$Res>
    extends _$ServiceModelCopyWithImpl<$Res, _$ServiceModelImpl>
    implements _$$ServiceModelImplCopyWith<$Res> {
  __$$ServiceModelImplCopyWithImpl(
      _$ServiceModelImpl _value, $Res Function(_$ServiceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titles = null,
    Object? descriptions = null,
    Object? image = null,
    Object? url = null,
    Object? urlLaunchMode = null,
    Object? backgroundColor = freezed,
    Object? foregroundColor = null,
    Object? gradientColors = freezed,
    Object? gradientBegin = freezed,
    Object? gradientEnd = freezed,
  }) {
    return _then(_$ServiceModelImpl(
      titles: null == titles
          ? _value._titles
          : titles // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      descriptions: null == descriptions
          ? _value._descriptions
          : descriptions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      urlLaunchMode: null == urlLaunchMode
          ? _value.urlLaunchMode
          : urlLaunchMode // ignore: cast_nullable_to_non_nullable
              as LaunchMode,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      foregroundColor: null == foregroundColor
          ? _value.foregroundColor
          : foregroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      gradientColors: freezed == gradientColors
          ? _value._gradientColors
          : gradientColors // ignore: cast_nullable_to_non_nullable
              as List<Color>?,
      gradientBegin: freezed == gradientBegin
          ? _value.gradientBegin
          : gradientBegin // ignore: cast_nullable_to_non_nullable
              as Alignment?,
      gradientEnd: freezed == gradientEnd
          ? _value.gradientEnd
          : gradientEnd // ignore: cast_nullable_to_non_nullable
              as Alignment?,
    ));
  }
}

/// @nodoc

@JsonSerializable(converters: [
  _LaunchModeJsonConverter(),
  _ColorJsonConverter(),
  _AlignmentJsonConverter()
])
class _$ServiceModelImpl extends _ServiceModel {
  const _$ServiceModelImpl(
      {required final Map<String, String> titles,
      required final Map<String, String> descriptions,
      required this.image,
      required this.url,
      required this.urlLaunchMode,
      required this.backgroundColor,
      required this.foregroundColor,
      required final List<Color>? gradientColors,
      required this.gradientBegin,
      required this.gradientEnd})
      : _titles = titles,
        _descriptions = descriptions,
        _gradientColors = gradientColors,
        super._();

  factory _$ServiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceModelImplFromJson(json);

// map of language code to title
  final Map<String, String> _titles;
// map of language code to title
  @override
  Map<String, String> get titles {
    if (_titles is EqualUnmodifiableMapView) return _titles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_titles);
  }

  final Map<String, String> _descriptions;
  @override
  Map<String, String> get descriptions {
    if (_descriptions is EqualUnmodifiableMapView) return _descriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_descriptions);
  }

// SVG or PNG
  @override
  final String image;
// Deeplink or link
  @override
  final String url;
  @override
  final LaunchMode urlLaunchMode;
// colors
  @override
  final Color? backgroundColor;
  @override
  final Color foregroundColor;
// gradient
  final List<Color>? _gradientColors;
// gradient
  @override
  List<Color>? get gradientColors {
    final value = _gradientColors;
    if (value == null) return null;
    if (_gradientColors is EqualUnmodifiableListView) return _gradientColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Alignment? gradientBegin;
  @override
  final Alignment? gradientEnd;

  @override
  String toString() {
    return 'ServiceModel(titles: $titles, descriptions: $descriptions, image: $image, url: $url, urlLaunchMode: $urlLaunchMode, backgroundColor: $backgroundColor, foregroundColor: $foregroundColor, gradientColors: $gradientColors, gradientBegin: $gradientBegin, gradientEnd: $gradientEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceModelImpl &&
            const DeepCollectionEquality().equals(other._titles, _titles) &&
            const DeepCollectionEquality()
                .equals(other._descriptions, _descriptions) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.urlLaunchMode, urlLaunchMode) ||
                other.urlLaunchMode == urlLaunchMode) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.foregroundColor, foregroundColor) ||
                other.foregroundColor == foregroundColor) &&
            const DeepCollectionEquality()
                .equals(other._gradientColors, _gradientColors) &&
            (identical(other.gradientBegin, gradientBegin) ||
                other.gradientBegin == gradientBegin) &&
            (identical(other.gradientEnd, gradientEnd) ||
                other.gradientEnd == gradientEnd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_titles),
      const DeepCollectionEquality().hash(_descriptions),
      image,
      url,
      urlLaunchMode,
      backgroundColor,
      foregroundColor,
      const DeepCollectionEquality().hash(_gradientColors),
      gradientBegin,
      gradientEnd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceModelImplCopyWith<_$ServiceModelImpl> get copyWith =>
      __$$ServiceModelImplCopyWithImpl<_$ServiceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceModelImplToJson(
      this,
    );
  }
}

abstract class _ServiceModel extends ServiceModel {
  const factory _ServiceModel(
      {required final Map<String, String> titles,
      required final Map<String, String> descriptions,
      required final String image,
      required final String url,
      required final LaunchMode urlLaunchMode,
      required final Color? backgroundColor,
      required final Color foregroundColor,
      required final List<Color>? gradientColors,
      required final Alignment? gradientBegin,
      required final Alignment? gradientEnd}) = _$ServiceModelImpl;
  const _ServiceModel._() : super._();

  factory _ServiceModel.fromJson(Map<String, dynamic> json) =
      _$ServiceModelImpl.fromJson;

  @override // map of language code to title
  Map<String, String> get titles;
  @override
  Map<String, String> get descriptions;
  @override // SVG or PNG
  String get image;
  @override // Deeplink or link
  String get url;
  @override
  LaunchMode get urlLaunchMode;
  @override // colors
  Color? get backgroundColor;
  @override
  Color get foregroundColor;
  @override // gradient
  List<Color>? get gradientColors;
  @override
  Alignment? get gradientBegin;
  @override
  Alignment? get gradientEnd;
  @override
  @JsonKey(ignore: true)
  _$$ServiceModelImplCopyWith<_$ServiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
