import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extra/langs/locale_keys.g.dart';
import '../../shared/providers.dart';

class SignInForm extends HookConsumerWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showErrorMessages = ref.watch(
      signInFormNotifierProvider.select((state) => state.showErrorMessages),
    );

    return Form(
      autovalidateMode: showErrorMessages
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => ref
                .read(signInFormNotifierProvider.notifier)
                .changeEmail(value),
            validator: (_) =>
                ref.read(signInFormNotifierProvider).email.value.fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) =>
                            LocaleKeys.validEmailVerificationText.tr(),
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              labelText: LocaleKeys.password.tr(),
            ),
            obscureText: true,
            onChanged: (value) => ref
                .read(signInFormNotifierProvider.notifier)
                .changePassword(value),
            validator: (_) =>
                ref.read(signInFormNotifierProvider).password.value.fold(
                      (f) => f.maybeMap(
                        shortPassword: (_) =>
                            LocaleKeys.shortPasswordVerificationText.tr(),
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
          ),
        ],
      ),
    );
  }
}
