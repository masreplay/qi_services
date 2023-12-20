import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qi_services/api/models/login_model.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/phone_number/phone_number.dart';
import 'package:useful_hook/useful_hook.dart';

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

    final obscure = useState(false);

    final l10n = context.l10n;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Assets.app.logo.image(
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        Text(
                          l10n.appName,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox.square(dimension: 24.0),
                  PhoneNumberFormField(
                    areaCode: areaCode.value,
                    onAreaCodeChanged: areaCode.update,
                    controller: mobileNumber,
                  ),
                  const SizedBox.square(dimension: 24.0),
                  TextFormField(
                    controller: password,
                    obscureText: obscure.value,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: l10n.password,
                      prefixIcon: const Icon(AppIcons.password),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure.value ? AppIcons.visible : AppIcons.invisible,
                        ),
                        onPressed: () {
                          obscure.value = !obscure.value;
                        },
                      ),
                    ),
                  ),
                  const SizedBox.square(dimension: 24.0),
                  FilledButton(
                    onPressed: () async {
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

                      await state(LoginRepository.instance.login(body));

                      state.value.whenOrNull(
                        data: (data) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.loginSuccessfully)),
                          );
                        },
                        error: (error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.defaultErrorMessage)),
                          );
                        },
                      );
                    },
                    child: Text(l10n.login),
                  ),
                  const SizedBox.square(dimension: 16.0),
                  TextButton(
                    onPressed: () {},
                    child: Text(l10n.forgotYourPassword),
                  ),
                  const SizedBox.square(dimension: 16.0),
                  TextButton(
                    onPressed: () {},
                    child: Text(l10n.createNewAccount),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
