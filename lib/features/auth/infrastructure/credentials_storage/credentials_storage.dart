abstract class CredentialsStorage {
  Future<String?> read();

  Future<void> save(String credentials);

  Future<void> clear();
}
