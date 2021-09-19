import 'package:dio/dio.dart';

import 'auth_repository.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._repository);

  final AuthRepository _repository;

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final storedCredentials = await _repository.getSignedInCredentials();

    final RequestOptions modifiedOptions = options
      ..headers.addAll(
        storedCredentials == null
            ? <String, String>{}
            : <String, String>{'Authorization': 'bearer $storedCredentials'},
      );

    handler.next(modifiedOptions);
  }
}
