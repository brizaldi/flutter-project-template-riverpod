import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.cache() = _Cache;
  const factory AuthFailure.server([int? errorCode, String? message]) = _Server;
  const factory AuthFailure.noConnection() = _NoConnection;
}
