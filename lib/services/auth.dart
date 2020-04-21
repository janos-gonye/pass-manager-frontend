import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/models/auth_credential.dart';
import 'package:pass_manager_frontend/services/api.dart';

class AuthService extends ApiService {
  static const String _accesTokenName = 'accessToken';
  static const _refreshTokenName = 'refreshToken';
  static final _secureStorage = FlutterSecureStorage();

  Future<bool> login(AuthCredential authCredential) async {
    http.Response response = await post(
      constants.PATH_OBTAIN_TOKENS, authCredential.toJson());
    if (response.statusCode == 401) {
      return false;
    } else if (response.statusCode == 200) {
      final Map <String, dynamic> tokens = json.decode(response.body.toString());
      accessToken = tokens["access"];
      refreshToken = tokens["refresh"];
      return true;
    }
    // TODO: Handle exceptions and other status codes.
  }

  static void _setToken({@required String key, @required String value}) {
    _secureStorage.write(key: key, value: value);
  }

  static Future<String> _getToken({@required String key}) async {
    return await _secureStorage.read(key: key);
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
