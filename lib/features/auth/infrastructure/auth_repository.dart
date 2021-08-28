import 'package:dartz/dartz.dart';

import '../../core/infrastructure/exceptions.dart';
import '../domain/auth_failure.dart';
import '../domain/value_objects.dart';
import 'auth_local_service.dart';
import 'auth_remote_service.dart';

class AuthRepository {
  AuthRepository(
    this._localService,
    this._remoteService,
  );

  final AuthLocalService _localService;
  final AuthRemoteService _remoteService;

  Future<bool> getSignedInStatus() async {
    final token = await _localService.getCachedToken();
    return token != null;
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _remoteService.signOut();
      await _localService.clearCachedToken();

      return right(unit);
    } on RestApiException catch (e) {
      return left(AuthFailure.server(e.errorCode));
    } on NoConnectionException {
      return left(const AuthFailure.noConnection());
    }
  }

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required Email email,
    required Password password,
  }) async {
    try {
      final emailStr = email.getOrCrash();
      final passwordStr = password.getOrCrash();

      final authResponse = await _remoteService.signIn(
        email: emailStr,
        password: passwordStr,
      );

      return authResponse.when(
        withToken: (token) async {
          await _localService.cacheToken(token);
          return right(unit);
        },
        failure: (errorCode, message) => left(AuthFailure.server(
          errorCode,
          message,
        )),
      );
    } on RestApiException catch (e) {
      return left(AuthFailure.server(e.errorCode));
    } on NoConnectionException {
      return left(const AuthFailure.noConnection());
    }
  }
}
