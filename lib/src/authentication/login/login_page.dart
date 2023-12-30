import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
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
    final password = useTextEditingController();

    final l10n = context.l10n;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final formBody = <Widget>[
      PhoneNumberFormField(onChanged: phone.update),
      PasswordFormField(controller: password, optional: false),
      FilledButton(
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
        onPressed: () {},
        child: Text(l10n.forgotYourPassword),
      ),
      TextButton(
        onPressed: () => showUnimplementedFeature(context: context),
        child: Text(l10n.createNewAccount),
      ),
    ];

    final logo = Center(
      child: ColumnPadded(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppLogo(
            dimension: 124.0,
            borderRadius: BorderRadius.circular(24),
          ),
          const AppNameText(fontSize: 28),
        ],
      ),
    );

    return Scaffold(
      body: Responsive.maybeWhen(
        context: context,
        compact: () {
          return FormBody(
            formKey: formKey,
            spacing: Insets.medium,
            padding: const EdgeInsets.all(Insets.medium),
            maxWidth: 500,
            children: [
              logo,
              ...formBody,
            ],
          );
        },
        orElse: () {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding: const EdgeInsets.all(Insets.large),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: logo,
                    ),
                    Expanded(
                      flex: 3,
                      child: FormBody(
                        formKey: formKey,
                        spacing: Insets.medium,
                        children: formBody,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
