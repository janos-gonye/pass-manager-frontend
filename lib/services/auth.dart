import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/models/auth_credential.dart';
import 'package:pass_manager_frontend/services/api.dart';
import 'package:pass_manager_frontend/services/profile_crypter_storage.dart';

class AuthService extends ApiService {
  static const String _accesTokenName = 'accessToken';
  static const _refreshTokenName = 'refreshToken';
  static final _secureStorage = FlutterSecureStorage();

  Future<void> login(AuthCredential authCredential) async {
    final http.Response response =
        await post(constants.PATH_OBTAIN_TOKENS, authCredential.toJson());
    final Map<String, dynamic> tokens = json.decode(response.body.toString());
    setAccessToken(tokens["access"]);
    setRefreshToken(tokens["refresh"]);
  }

  void logout() {
    deleteAccessToken();
    deleteRefreshToken();
    ProfileCrypterStorageService.crypter.masterPassword = null;
  }

  static void _setToken({@required String key, @required String value}) {
    _secureStorage.write(key: key, value: value);
  }

  static void _deleteKey({@required String key}) {
    _secureStorage.delete(key: key);
  }

  static Future<String> _getToken({@required String key}) async {
    return await _secureStorage.read(key: key);
  }

  static void setAccessToken(String value) {
    _setToken(key: _accesTokenName, value: value);
  }

  static Future<String> get accessToken async {
    return _getToken(key: _accesTokenName);
  }

  static void setRefreshToken(String value) {
    _setToken(key: _refreshTokenName, value: value);
  }

  static Future<String> get refreshToken async {
    return _getToken(key: _refreshTokenName);
  }

  static void deleteRefreshToken() async {
    _deleteKey(key: _refreshTokenName);
  }

  static void deleteAccessToken() async {
    _deleteKey(key: _accesTokenName);
  }
}
