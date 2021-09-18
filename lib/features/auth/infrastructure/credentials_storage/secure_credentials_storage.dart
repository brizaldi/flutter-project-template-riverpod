import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'credentials_storage.dart';

class SecureCredentialsStorage implements CredentialsStorage {
  SecureCredentialsStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _key = 'credentials';

  String? _cachedCredentials;

  @override
  Future<void> clear() {
    _cachedCredentials = null;
    return _storage.delete(key: _key);
  }

  @override
  Future<String?> read() async {
    if (_cachedCredentials != null) {
      return _cachedCredentials;
    }

    final storedCredentials = await _storage.read(key: _key);
    if (storedCredentials == null) {
      return null;
    }

    try {
      return _cachedCredentials = storedCredentials;
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> save(String credentials) {
    _cachedCredentials = credentials;

    return _storage.write(
      key: _key,
      value: credentials,
    );
  }
}
