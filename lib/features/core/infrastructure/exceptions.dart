class CacheException implements Exception {}

class RestApiException implements Exception {
  RestApiException(this.errorCode);

  final int? errorCode;
}

class NoConnectionException implements Exception {}

class UnknownException implements Exception {}
