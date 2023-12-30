import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qi_services/common_lib.dart';

// TODO: allow adding 0 at the beginning of the iraqi phone number
class PhoneNumberFormField extends HookWidget {
  const PhoneNumberFormField({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<PhoneNumber?> onChanged;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return InternationalPhoneNumberInput(
      onInputChanged: onChanged,
      inputBorder: const OutlineInputBorder(),
      selectorConfig: SelectorConfig(
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: Insets.medium,
        selectorType: Responsive.maybeWhen(
          context: context,
          orElse: () => PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        useBottomSheetSafeArea: true,
      ),
      locale: context.l10n.localeName,
      countries: const ["IQ", "US", "GB", "AE"],
      autoValidateMode: AutovalidateMode.disabled,
      textFieldController: controller,
      keyboardType: const TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
    );
  }
}

extension PhoneNumberX on PhoneNumber {
  String get full => dialCode! + phoneNumber!;
}
