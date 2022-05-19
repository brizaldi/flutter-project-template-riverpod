import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/l10n.dart';
import '../../shared/providers.dart';
import 'sign_in_form.dart';

class SignInScaffold extends HookConsumerWidget {
  const SignInScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.signIn),
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
              child: Text(l10n.signIn),
            ),
          ],
        ),
      ),
    );
  }
}
