import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extra/langs/locale_keys.g.dart';
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
      (failureOrSuccessOption) => failureOrSuccessOption.fold(
        () {},
        (either) => either.fold(
          (failure) => AlertHelper.showSnackBar(
            context,
            message: failure.map(
              cache: (_) => LocaleKeys.cacheUserError.tr(),
              server: (value) => value.message ?? LocaleKeys.serverError.tr(),
              noConnection: (_) => LocaleKeys.noConnectionError.tr(),
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
