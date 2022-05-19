import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/l10n.dart';
import '../../core/presentation/widgets/alert_helper.dart';
import '../../core/presentation/widgets/loading_overlay.dart';
import '../domain/auth_failure.dart';
import '../shared/providers.dart';
import 'widgets/sign_in_scaffold.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    ref.listen<Option<Either<AuthFailure, Unit>>>(
      signInFormNotifierProvider.select(
        (state) => state.failureOrSuccessOption,
      ),
      (_, failureOrSuccessOption) => failureOrSuccessOption.fold(
        () {},
        (either) => either.fold(
          (failure) => AlertHelper.showSnackBar(
            context,
            message: failure.map(
              storage: (_) => l10n.storageError,
              server: (value) => value.message ?? l10n.serverError,
              noConnection: (_) => l10n.noConnectionError,
            ),
          ),
          (_) => ref
              .read(authNotifierProvider.notifier)
              .checkAndUpdateAuthStatus(),
        ),
      ),
    );

    final isSubmitting = ref.watch(
      signInFormNotifierProvider.select((state) => state.isSubmitting),
    );

    return Stack(
      children: [
        const SignInScaffold(),
        LoadingOverlay(isLoading: isSubmitting),
      ],
    );
  }
}
