import 'package:hive_flutter/hive_flutter.dart';

import '../../../constants/strings.dart';

class HiveDatabase {
  late Box<dynamic> _box;

  Box<dynamic> get box => _box;

  bool _hasBeenInitialized = false;

  Future<void> init() async {
    if (_hasBeenInitialized) return;

    _hasBeenInitialized = true;

    await Hive.initFlutter();
    _box = await Hive.openBox<String>(Strings.appCodeName);
  }
}
