import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qi_services/api/models/login_model.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/faker.dart';
import 'package:qi_services/phone_number/phone_number.dart';
import 'package:qi_services/src/authentication/login/password_form_field.dart';
import 'package:qi_services/src/main/main.dart';
import 'package:useful_hook/useful_hook.dart';

import 'app_logo.dart';
import 'form_body.dart';
import 'login_repository.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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

                    // Fake login (instantly)
                    await state(LoginRepository.instance.login(body));

                    state.value.whenOrNull(
                      data: (data) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.loginSuccessfully)),
                        );
                        Navigator.of(context).push(
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
                ? const SizedBox.square(
                    dimension: 18.0,
                    child: CircularProgressIndicator(),
                  )
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
