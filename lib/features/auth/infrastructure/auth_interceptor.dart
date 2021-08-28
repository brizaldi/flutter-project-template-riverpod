import 'package:dio/dio.dart';

import 'auth_local_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._localService);

  final AuthLocalService _localService;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _localService.getCachedToken();
    final modifiedOptions = options
      ..headers.addAll(
        token == null ? {} : {'Authorization': 'bearer $token'},
      );
    handler.next(modifiedOptions);
  }
}
