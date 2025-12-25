import 'dart:convert';

import 'package:ezdu/features/auth/models/auth_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _authKey = 'auth_data';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> saveAuthData(AuthModel auth) async {
    final jsonString = jsonEncode(auth.toJson());
    await _storage.write(key: _authKey, value: jsonString);
  }

  Future<AuthModel?> getAuthData() async {
    final jsonString = await _storage.read(key: _authKey);
    if (jsonString == null) return null;

    final Map<String, dynamic> json = jsonDecode(jsonString);
    return AuthModel.toModel(json);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}