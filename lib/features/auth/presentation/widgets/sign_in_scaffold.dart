import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extra/langs/locale_keys.g.dart';
import '../../shared/providers.dart';
import 'sign_in_form.dart';

class SignInScaffold extends HookConsumerWidget {
  const SignInScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.signIn.tr()),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SignInForm(),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                ref
                    .read(signInFormNotifierProvider.notifier)
                    .signInWithEmailAndPassword();
              },
              child: Text(LocaleKeys.signIn.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
