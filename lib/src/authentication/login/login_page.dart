import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/phone_number/phone_number.dart';
import 'package:useful_hook/useful_hook.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = useAsyncState();

    final textTheme = theme.textTheme;

    final formKey = useFormKey();

    final areaCode = useState<AreaCode>(iraqAreaCode);
    final mobileNumber = useTextEditingController();
    final password = useTextEditingController();

    final obscure = useState(false);

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
                          "Qi Services",
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox.square(dimension: 24.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: TextEditingController(
                            text: areaCode.value.code,
                          ),
                          readOnly: true,
                          onTap: () async {
                            final value = await showAreaCodeBottomSheet(
                              context: context,
                              value: areaCode.value,
                            );

                            if (value != null) areaCode.value = value;
                          },
                          decoration: const InputDecoration(
                            labelText: "Area Code",
                          ),
                        ),
                      ),
                      const SizedBox.square(dimension: 8.0),
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          controller: mobileNumber,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Mobile Number",
                            prefixIcon: Icon(AppIcons.phone),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox.square(dimension: 24.0),
                  TextFormField(
                    controller: password,
                    obscureText: obscure.value,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Password",
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
                      final phone = PhoneNumberUtils.merge(
                        areaCode: areaCode.value,
                        mobileNumber: mobileNumber.text,
                      );

                      // await state();
                    },
                    child: const Text("Login"),
                  ),
                  const SizedBox.square(dimension: 16.0),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Your Password?"),
                  ),
                  const SizedBox.square(dimension: 16.0),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Create new account"),
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
