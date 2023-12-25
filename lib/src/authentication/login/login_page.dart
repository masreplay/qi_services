import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/faker.dart';
import 'package:qi_services/phone_number/phone_number.dart';
import 'package:qi_services/src/authentication/authentication.dart';
import 'package:qi_services/src/main/main.dart';
import 'package:useful_hook/useful_hook.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useAsyncState();

    final formKey = useFormKey();

    final areaCode = useState<AreaCode>(iraqAreaCode);
    final mobileNumber = useTextEditingController();
    final password = useTextEditingController();

    final l10n = context.l10n;

    return Scaffold(
      body: FormBody(
        formKey: formKey,
        children: [
          Center(
            child: InkWell(
              onTap: !kDebugMode
                  ? null
                  : () {
                      mobileNumber.text = AppFaker.mobileNumber;
                      password.text = AppFaker.password;
                    },
              child: const AppLogo(),
            ),
          ),
          const SizedBox.square(dimension: 24.0),
          PhoneNumberFormField(
            controller: mobileNumber,
            areaCode: areaCode.value,
            onAreaCodeChanged: areaCode.update,
            optional: false,
          ),
          const SizedBox.square(dimension: 24.0),
          PasswordFormField(
            controller: password,
            optional: false,
          ),
          const SizedBox.square(dimension: 24.0),
          FilledButton(
            onPressed: state.value.isLoading
                ? null
                : () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    final body = LoginRequest(
                      phone: PhoneNumberConvertor.merge(
                        areaCode: areaCode.value,
                        mobileNumber: mobileNumber.text,
                      ),
                      password: password.text,
                    );

                    await state(ref.read(loginRepositoryProvider).login(body));

                    state.value.whenOrNull(
                      data: (data) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.loginSuccessfully)),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const MainPage(),
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.defaultErrorMessage)),
                        );
                      },
                    );
                  },
            child: state.value.isLoading
                ? const ButtonLoading()
                : Text(l10n.login),
          ),
          const SizedBox.square(dimension: 16.0),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.notImplementedYet)),
              );
            },
            child: Text(l10n.forgotYourPassword),
          ),
          const SizedBox.square(dimension: 16.0),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.notImplementedYet)),
              );
            },
            child: Text(l10n.createNewAccount),
          ),
        ],
      ),
    );
  }
}

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 18.0,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.0,
        ),
      ),
    );
  }
}
