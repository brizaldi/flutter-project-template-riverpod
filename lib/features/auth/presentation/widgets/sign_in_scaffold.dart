import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/providers.dart';
import 'sign_in_form.dart';

class SignInScaffold extends HookConsumerWidget {
  const SignInScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.signIn),
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
              child: Text(AppLocalizations.of(context)!.signIn),
            ),
          ],
        ),
      ),
    );
  }
}
