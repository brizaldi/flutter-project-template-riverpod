import 'package:dio/dio.dart';

import 'auth_repository.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._repository);

  final AuthRepository _repository;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final storedCredentials = await _repository.getSignedInCredentials();
    final modifiedOptions = options
      ..headers.addAll(
        storedCredentials == null
            ? {}
            : {'Authorization': 'bearer $storedCredentials'},
      );
    handler.next(modifiedOptions);
  }
}
