import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qi_services/api/api.dart';
import 'package:qi_services/common_lib.dart';
import 'package:qi_services/src/authentication/authentication.dart';

@RoutePage()
class ForgotPasswordPage extends HookConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useAsyncState<ForgotPasswordResponse>();

    final formKey = useFormKey();

    final phone = useState<PhoneNumber?>(null);

    final l10n = context.l10n;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final formBody = <Widget>[
      PhoneNumberFormField(onChanged: phone.update),
      FilledButton(
        onPressed: state.value.isLoading
            ? null
            : () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                final body = ForgotPasswordRequest(
                  phone: phone.value!.full,
                );

                await state(
                  ref
                      .read(authenticationRepositoryProvider)
                      .forgotPassword(body),
                );

                state.value.whenOrNull(
                  data: (data) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text(l10n.forgotPasswordSuccess)),
                    );

                    // TODO: Implement otp page
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
            : Text(l10n.continueOption),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.forgotPassword),
      ),
      body: Responsive.maybeWhen(
        context: context,
        compact: () {
          const spacing = Insets.medium;

          return FormBody(
            formKey: formKey,
            spacing: spacing,
            padding: const EdgeInsets.all(spacing),
            maxWidth: 500,
            children: formBody,
          );
        },
        orElse: () {
          const spacing = Insets.large;

          return FormBody(
            formKey: formKey,
            spacing: spacing,
            padding: const EdgeInsets.all(spacing),
            maxWidth: 500,
            children: formBody,
          );
        },
      ),
    );
  }
}
