import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/presentation/widgets/alert_helper.dart';
import '../../core/presentation/widgets/loading_overlay.dart';
import '../domain/auth_failure.dart';
import '../shared/providers.dart';
import 'widgets/sign_in_scaffold.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              storage: (_) => AppLocalizations.of(context)!.storageError,
              server: (value) =>
                  value.message ?? AppLocalizations.of(context)!.serverError,
              noConnection: (_) =>
                  AppLocalizations.of(context)!.noConnectionError,
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
