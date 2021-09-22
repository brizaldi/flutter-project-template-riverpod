import 'package:dio/dio.dart';

import '../../core/infrastructure/dio_extensions.dart';
import '../../core/infrastructure/exceptions.dart';
import 'auth_response.dart';

class AuthRemoteService {
  AuthRemoteService(this._dio);

  final Dio _dio;

  Future<void> signOut() async {
    try {
      await _dio.get<dynamic>('logout');
    } on DioError catch (e) {
      if (e.isNoConnectionError || e.isConnectionTimeout) {
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
      final response = await _dio.post<Map<String, dynamic>>(
        'login',
        data: <String, String>{
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        final token = response.data?['token'] as String?;

        if (token != null) {
          return AuthResponse.withToken(token);
        } else {
          return const AuthResponse.failure(
            errorCode: 404,
            message: 'Credential token not found',
          );
        }
      } else {
        final message = response.data?['message'] as String?;
        return AuthResponse.failure(
          errorCode: response.statusCode,
          message: message,
        );
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError || e.isConnectionTimeout) {
        throw NoConnectionException();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
