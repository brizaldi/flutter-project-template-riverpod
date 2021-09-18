import 'package:dio/dio.dart';

import '../../core/infrastructure/dio_extensions.dart';
import '../../core/infrastructure/exceptions.dart';
import 'auth_response.dart';

class AuthRemoteService {
  AuthRemoteService(this._dio);

  final Dio _dio;

  Future<void> signOut() async {
    try {
      await _dio.get('logout');
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        throw NoConnectionException();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        final token = responseData['token'];

        return AuthResponse.withToken(token);
      } else {
        if (response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          return AuthResponse.failure(
            errorCode: response.statusCode,
            message: responseData['message'],
          );
        } else {
          return AuthResponse.failure(
            errorCode: response.statusCode,
          );
        }
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        throw NoConnectionException();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
