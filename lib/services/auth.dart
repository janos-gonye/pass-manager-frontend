import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/models/auth_credential.dart';
import 'package:pass_manager_frontend/services/api.dart';

class AuthService extends ApiService {
  static const String _accesTokenName = 'accessToken';
  static const String _refreshTokenName = 'refreshToken';

  static Future<bool> login(AuthCredential authCredential) async {
    Response response = await post(
      constants.PATH_OBTAIN_TOKENS,
      body: authCredential.toJson());
    if (response.statusCode == 401) {
      return false;
    }
    final Map <String, String> tokens = jsonDecode(response.body);
    accessToken = tokens["access"];
    refreshToken = tokens["refresh"];
    return true;
  }

  static void _setToken({@required String key, @required String value}) {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    secureStorage.write(key: key, value: value);
  }

  static Future<String> _getToken({@required String key}) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }

  static set accessToken(String value) {
    return _setToken(key: _accesTokenName, value: value);
  }

  static Future<String> get accessToken async {
    return _getToken(key: _accesTokenName);
  }

  static set refreshToken(String value) {
    return _setToken(key: _refreshTokenName, value: value);
  }

  static Future<String> get refreshToken async {
    return _getToken(key: _refreshTokenName);
  }

}
