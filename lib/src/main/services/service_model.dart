import 'package:flutter_svg/svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/url.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'services.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

@freezed
class ServiceModel with _$ServiceModel {
  const ServiceModel._();

  @JsonSerializable(
    converters: [
      _LaunchModeJsonConverter(),
      _ColorJsonConverter(),
      _AlignmentJsonConverter(),
    ],
  )
  const factory ServiceModel({
    required String title,
    required String description,

    // SVG or PNG
    required String image,

    // Deeplink or link
    required String url,
    required LaunchMode urlLaunchMode,

    // colors
    required Color? backgroundColor,
    required Color foregroundColor,

    // gradient
    required List<Color>? gradientColors,
    required Alignment? gradientBegin,
    required Alignment? gradientEnd,
  }) = _ServiceModel;

  ServiceData toServiceData({
    required BuildContext context,
  }) {
    return ServiceData(
      title: title,
      description: description,
      foregroundColor: foregroundColor,
      icon: _ImageNetwork(
        image,
        fit: BoxFit.contain,
        color: foregroundColor,
      ),
      onTap: () {
        launchDeeplinkOrUrlString(context: context, url: url);
      },
      gradient: gradientColors == null
          ? null
          : LinearGradient(
              begin: gradientBegin ?? Alignment.centerLeft,
              end: gradientEnd ?? Alignment.centerRight,
              colors: gradientColors!,
            ),
    );
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);
}

class _ColorJsonConverter implements JsonConverter<Color, String> {
  const _ColorJsonConverter();

  @override
  Color fromJson(String json) {
    return Color(int.parse(json, radix: 16));
  }

  @override
  String toJson(Color color) {
    return color.value.toRadixString(16);
  }
}

class _AlignmentJsonConverter implements JsonConverter<Alignment, String> {
  const _AlignmentJsonConverter();

  @override
  Alignment fromJson(String json) {
    final parts = json.split('.');

    return Alignment(
      double.parse(parts[0]),
      double.parse(parts[1]),
    );
  }

  @override
  String toJson(Alignment alignment) {
    return '${alignment.x}.${alignment.y}';
  }
}

class _LaunchModeJsonConverter implements JsonConverter<LaunchMode, String> {
  const _LaunchModeJsonConverter();

  @override
  LaunchMode fromJson(String json) {
    return LaunchMode.values.firstWhere(
      (element) => element.name == json,
    );
  }

  @override
  String toJson(LaunchMode launchMode) {
    return launchMode.name;
  }
}

class _ImageNetwork extends StatelessWidget {
  const _ImageNetwork(
    this.src, {
    required this.fit,
    required this.color,
  });

  final String src;
  final BoxFit fit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final fileExtension = src.split('.').lastOrNull?.toLowerCase();

    if (fileExtension == 'svg') {
      return SvgPicture.network(
        src,
        fit: fit,
        // ignore: deprecated_member_use
        color: color,
      );
    } else {
      return Image.network(
        src,
        fit: fit,
      );
    }
  }
}