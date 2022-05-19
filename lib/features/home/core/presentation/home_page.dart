import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/l10n.dart';
import '../../../auth/application/sign_out/sign_out_notifier.dart';
import '../../../auth/shared/providers.dart';
import '../../../core/presentation/widgets/alert_helper.dart';
import '../../../core/presentation/widgets/loading_overlay.dart';
import 'widgets/home_scaffold.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    ref.listen<SignOutState>(
      signOutNotifierProvider,
      (_, state) => state.maybeWhen(
        orElse: () => null,
        success: () =>
            ref.read(authNotifierProvider.notifier).checkAndUpdateAuthStatus(),
        failure: (failure) => AlertHelper.showSnackBar(
          context,
          message: failure.map(
            storage: (_) => l10n.storageError,
            server: (value) => value.message ?? l10n.serverError,
            noConnection: (_) => l10n.noConnectionError,
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
