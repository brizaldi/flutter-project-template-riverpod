import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../infrastructure/hive_database.dart';

final dioProvider = Provider((ref) => Dio());

final hiveProvider = Provider(
  (ref) => HiveDatabase(),
);
