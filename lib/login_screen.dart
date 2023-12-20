import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qi_services/area_code_bottom_sheet.dart';
import 'package:qi_services/icons.dart';
import 'package:useful_hook/useful_hook.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final areaCode = useState<AreaCode>(iraqAreaCode);
    final mobileNumber = useTextEditingController();
    final password = useTextEditingController();
    final obscure = useState(false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ColumnPadded(
            gap: 24.0,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Qi Services",
                  style: textTheme.titleLarge,
                ),
              ),
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
              FilledButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Forgot Your Password?"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Create new account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
