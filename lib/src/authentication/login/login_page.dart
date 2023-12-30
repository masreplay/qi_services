import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/faker.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:qi_services/unimplemented.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useAsyncState<LoginResponse>();

    final formKey = useFormKey();

    final phone = useState<PhoneNumber?>(null);
    final phoneController = useTextEditingController();
    final password = useTextEditingController();

    final l10n = context.l10n;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      body: FormBody(
        formKey: formKey,
        spacing: Insets.medium,
        children: [
          PhoneNumberFormField(
            controller: phoneController,
            onChanged: phone.update,
          ),
          PasswordFormField(
            controller: password,
            optional: false,
          ),
          FilledButton(
            onLongPress: !kDebugMode
                ? null
                : () {
                    phoneController.text = AppFaker.phone;
                    password.text = AppFaker.password;
                  },
            onPressed: state.value.isLoading
                ? null
                : () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    final body = LoginRequest(
                      phone: phone.value!.full,
                      password: password.text,
                    );

                    await state(
                      ref.read(authenticationRepositoryProvider).login(body),
                    );

                    state.value.whenOrNull(
                      data: (data) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text(l10n.loginSuccessfully)),
                        );
                        context.router.replace(const MainRoute());
                      },
                      error: (error, stackTrace) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(content: Text(l10n.defaultErrorMessage)),
                        );
                      },
                    );
                  },
            child: state.value.isLoading
                ? const ButtonLoading.filled()
                : Text(l10n.login),
          ),
          TextButton(
            onPressed: () {
              showUnimplementedFeature(context: context);
            },
            child: Text(l10n.forgotYourPassword),
          ),
          TextButton(
            onPressed: () {
              showUnimplementedFeature(context: context);
            },
            child: Text(l10n.createNewAccount),
          ),
        ],
      ),
    );
  }
}

// TODO: allow adding 0 at the beginning of the iraqi phone number
class PhoneNumberFormField extends StatelessWidget {
  const PhoneNumberFormField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;

  final ValueChanged<PhoneNumber?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: onChanged,
      inputBorder: const OutlineInputBorder(),
      selectorConfig: const SelectorConfig(
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: Insets.medium,
        selectorType: PhoneInputSelectorType.DIALOG,
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

extension on PhoneNumber {
  String get full => dialCode! + phoneNumber!;
}
