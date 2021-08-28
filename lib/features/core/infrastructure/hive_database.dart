import 'package:hive_flutter/hive_flutter.dart';

import '../../../extra/constants/strings.dart';

class HiveDatabase {
  late Box _box;

  Box get box => _box;

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    if (_hasBeenInitialized) return;

    _hasBeenInitialized = true;

    await Hive.initFlutter();
    _box = await Hive.openBox<String>(Strings.appCodeName);
  }
}
