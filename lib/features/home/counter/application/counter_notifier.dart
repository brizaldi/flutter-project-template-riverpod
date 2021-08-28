import 'package:hooks_riverpod/hooks_riverpod.dart';

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state = state + 1;
}
