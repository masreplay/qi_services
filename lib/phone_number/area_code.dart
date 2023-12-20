import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'area_code.g.dart';

typedef AreaCode = ({String code, String country});

const AreaCode iraqAreaCode = (country: "Iraq", code: "+964");

@riverpod
List<AreaCode> getAreaCodes(GetAreaCodesRef ref, String query) {
  // Can be replaced with a call to an API or Json file or whatever data source
  final values = [
    iraqAreaCode,
    (country: "United Arab Emirates", code: "+971"),
    (country: "United States", code: "+1"),
    (country: "United Kingdom", code: "+44"),
    (country: "Turkey", code: "+90"),
    (country: "Saudi Arabia", code: "+966"),
    (country: "Qatar", code: "+974"),
    (country: "Oman", code: "+968"),
    (country: "Kuwait", code: "+965"),
    (country: "Jordan", code: "+962"),
    (country: "Egypt", code: "+20"),
    (country: "Bahrain", code: "+973"),
  ];

  if (query.isEmpty) {
    return values;
  }

  return [
    for (final value in values)
      if (value.country.toLowerCase().contains(query.toLowerCase()) ||
          value.code.toLowerCase().contains(query.toLowerCase()))
        value,
  ];
}
