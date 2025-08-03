import 'package:Shartflix/core/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  CacheService() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  final String keyId = 'user_id';
  final String keyName = 'user_name';
  final String keyEmail = 'user_email';
  final String keyPhotoUrl = 'user_photo_url';
  final String keyToken = 'user_token';

  /// Save user data securely
  Future<void> saveUserData({
    required UserModel user,
  }) async {
    await _storage.write(key: keyId, value: user.id);
    await _storage.write(key: keyName, value: user.name);
    await _storage.write(key: keyEmail, value: user.email);
    await _storage.write(key: keyPhotoUrl, value: user.photoUrl);
    await _storage.write(key: keyToken, value: user.token);
  }

  /// Save user data securely
  Future<void> saveUserDataWithoutToken({
    required UserModel user,
  }) async {
    await _storage.write(key: keyId, value: user.id);
    await _storage.write(key: keyName, value: user.name);
    await _storage.write(key: keyEmail, value: user.email);
    await _storage.write(key: keyPhotoUrl, value: user.photoUrl);
  }

  /// Read user data securely
  Future<UserModel> readUserData() async {
    final id = await _storage.read(key: keyId);
    final name = await _storage.read(key: keyName);
    final email = await _storage.read(key: keyEmail);
    final photoUrl = await _storage.read(key: keyPhotoUrl);
    final token = await _storage.read(key: keyToken);

    return UserModel(
      email: email,
      id: id,
      name: name,
      photoUrl: photoUrl,
      token: token,
    );
  }

  /// Get Token
  Future<String?> readToken() async {
    final token = await _storage.read(key: keyToken);
    return token;
  }

  /// Delete all stored user data
  Future<void> clearUserData() async {
    await _storage.deleteAll();
  }
}
