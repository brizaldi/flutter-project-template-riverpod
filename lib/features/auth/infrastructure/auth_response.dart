import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.freezed.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse.withToken(String token) = _WithToken;
  const factory AuthResponse.failure({
    int? errorCode,
    String? message,
  }) = _Failure;

  const AuthResponse._();
}
