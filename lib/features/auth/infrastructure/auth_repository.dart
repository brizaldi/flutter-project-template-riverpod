import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../core/infrastructure/exceptions.dart';
import '../domain/auth_failure.dart';
import '../domain/value_objects.dart';
import 'auth_remote_service.dart';
import 'credentials_storage/credentials_storage.dart';

class AuthRepository {
  AuthRepository(
    this._credentialsStorage,
    this._remoteService,
  );

  final CredentialsStorage _credentialsStorage;
  final AuthRemoteService _remoteService;

  Future<bool> isSignedIn() =>
      getSignedInCredentials().then((credentials) => credentials != null);

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _remoteService.signOut();
    } on RestApiException catch (e) {
      return left(AuthFailure.server(e.errorCode));
    } on NoConnectionException {
      // Ignoring
    }

    return clearCredentialsStorage();
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
          await _credentialsStorage.save(token);
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

  Future<String?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();

      return storedCredentials;
    } on PlatformException {
      return null;
    }
  }

  Future<Either<AuthFailure, Unit>> clearCredentialsStorage() async {
    try {
      await _credentialsStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }
}
