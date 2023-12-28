import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qi_services/common_lib.dart';

class PasswordFormField extends HookWidget {
  const PasswordFormField({
    super.key,
    required this.controller,
    required this.optional,
  });

  final TextEditingController controller;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    final obscure = useState(true);
    final l10n = context.l10n;

    return TextFormField(
      controller: controller,
      obscureText: obscure.value,
      keyboardType: TextInputType.phone,
      validator: context.validator(optional: optional).build(),
      decoration: InputDecoration(
        labelText: l10n.password,
        prefixIcon: const Icon(DefaultIcons.password),
        suffixIcon: IconButton(
          icon: Icon(
            obscure.value ? DefaultIcons.visible : DefaultIcons.invisible,
          ),
          onPressed: () {
            obscure.value = !obscure.value;
          },
        ),
      ),
    );
  }
}
