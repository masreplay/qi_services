import 'package:qi_services/common_lib.dart';
import 'package:qi_services/validator/extension.dart';

import 'area_code.dart';
import 'area_code_bottom_sheet.dart';

class PhoneNumberFormField extends StatelessWidget {
  const PhoneNumberFormField({
    super.key,
    required this.controller,
    required this.optional,
    required this.areaCode,
    required this.onAreaCodeChanged,
  });

  final TextEditingController controller;
  final bool optional;
  final AreaCode areaCode;
  final ValueChanged<AreaCode> onAreaCodeChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final isIraqiAreaCode = areaCode.code == iraqAreaCode.code;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: TextEditingController(
              text: areaCode.code,
            ),
            readOnly: true,
            textAlign: TextAlign.center,
            onTap: () async {
              final value = await showAreaCodeBottomSheet(
                context: context,
                value: areaCode,
              );

              if (value != null) onAreaCodeChanged(value);
            },
            decoration: InputDecoration(
              label: FittedBox(child: Text(l10n.areaCode)),
            ),
          ),
        ),
        const SizedBox.square(dimension: 8.0),
        Expanded(
          flex: 4,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            validator: isIraqiAreaCode
                ? context.validator(optional: optional).build()
                : context.validator(optional: optional).build(),
            decoration: InputDecoration(
              labelText: l10n.mobileNumber,
              prefixIcon: const Icon(AppIcons.phone),
            ),
          ),
        ),
      ],
    );
  }
}
