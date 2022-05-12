import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../extra/routes/app_router.gr.dart';
import '../../../../auth/shared/providers.dart';
import '../../shared/providers.dart';

class HomeScaffold extends HookConsumerWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
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
        onPressed: () => context.pushRoute(const CounterRoute()),
        child: const Icon(Icons.chevron_right),
      ),
    );
  }
}
