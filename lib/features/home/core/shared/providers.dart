import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../counter/application/counter_notifier.dart';

final counterNotifierProvider =
    StateNotifierProvider.autoDispose<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);
