import '../../core/infrastructure/hive_database.dart';

class AuthLocalService {
  AuthLocalService(this._database);

  final HiveDatabase _database;
  final tokenKey = 'TOKEN';

  Future<String?> getCachedToken() async {
    final token = _database.box.get(tokenKey) as String?;
    return token;
  }

  Future<void> clearCachedToken() {
    return _database.box.clear();
  }

  Future<void> cacheToken(String token) {
    return _database.box.put(
      tokenKey,
      token,
    );
  }
}
