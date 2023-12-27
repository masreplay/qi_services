import 'package:qi_services/common_lib.dart';

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

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: isIraqiAreaCode
          ? context.validator(optional: optional).build()
          : context.validator(optional: optional).build(),
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        labelText: l10n.mobileNumber,
        prefixIcon: const Icon(DefaultAppIcons.phone),
        suffix: Directionality(
          textDirection: TextDirection.ltr,
          child: InkWell(
            onTap: () async {
              FocusScope.of(context).unfocus();
              final value = await showAreaCodeBottomSheet(
                context: context,
                value: areaCode,
              );

              if (value != null) onAreaCodeChanged(value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                areaCode.code,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
