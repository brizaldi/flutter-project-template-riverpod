import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../auth/shared/providers.dart';
import '../../../../core/application/routes/route_names.dart';
import '../../shared/providers.dart';

class HomeScaffold extends HookConsumerWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterNotifierProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(signOutNotifierProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () =>
                  ref.read(counterNotifierProvider.notifier).increment(),
              child: const Text('Increment'),
            ),
            Text(
              counterState.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(RouteNames.counterNameRoute),
        child: const Icon(Icons.chevron_right),
      ),
    );
  }
}
