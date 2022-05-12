import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extra/langs/locale_keys.g.dart';
import '../../../auth/application/sign_out/sign_out_notifier.dart';
import '../../../auth/shared/providers.dart';
import '../../../core/presentation/widgets/alert_helper.dart';
import '../../../core/presentation/widgets/loading_overlay.dart';
import 'widgets/home_scaffold.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignOutState>(
      signOutNotifierProvider,
      (_, state) => state.maybeWhen(
        orElse: () => null,
        success: () =>
            ref.read(authNotifierProvider.notifier).checkAndUpdateAuthStatus(),
        failure: (failure) => AlertHelper.showSnackBar(
          context,
          message: failure.map(
            storage: (_) => LocaleKeys.storageError.tr(),
            server: (value) => value.message ?? LocaleKeys.serverError.tr(),
            noConnection: (_) => LocaleKeys.noConnectionError.tr(),
          ),
        ),
      ),
    );

    final signOutState = ref.watch(signOutNotifierProvider);

    return Stack(
      children: [
        const HomeScaffold(),
        LoadingOverlay(
          isLoading: signOutState.maybeWhen(
            inProgress: () => true,
            orElse: () => false,
          ),
        ),
      ],
    );
  }
}
