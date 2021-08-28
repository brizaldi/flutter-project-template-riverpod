import 'dart:io';

import 'package:dio/dio.dart';

extension DioErrorX on DioError {
  bool get isNoConnectionError {
    return type == DioErrorType.other && error is SocketException;
  }
}
