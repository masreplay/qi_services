import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/icons.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'area_code_bottom_sheet.g.dart';

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

Future<AreaCode?> showAreaCodeBottomSheet({
  required BuildContext context,
  required AreaCode value,
}) {
  return showModalBottomSheet<AreaCode>(
    context: context,
    showDragHandle: true,
    enableDrag: true,
    builder: (context) {
      return HookConsumer(
        builder: (context, ref, child) {
          final controller = useTextEditingController();

          final codes = ref.watch(getAreaCodesProvider(controller.text));

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: "Search",
                    suffixIcon: Icon(AppIcons.search),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: codes.length,
                  itemBuilder: (context, index) {
                    final areaCode = codes[index];
                    return ListTile(
                      title: Text("${areaCode.country} (${areaCode.code})"),
                      onTap: () {
                        Navigator.of(context).pop(areaCode);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
