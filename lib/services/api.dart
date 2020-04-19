import 'dart:convert';
import 'package:http/http.dart';
import 'package:pass_manager_frontend/services/settings.dart';

class ApiService {

  static Future<Uri> _getServerUrl(String path) async {
    Uri url = await SettingsService.getServerUrl();
    return url.replace(path: path);
  }

  static Map<String, String> _headers(Map <String, String> headers) {
    headers = headers ?? {};
    headers["Content-Type"] = "application/json";
    headers["Accept"] = "application/json";
    return headers;
  }

  static Future<Response> get(String path, {Map<String, String> headers}) async {
    return await Client().get(await _getServerUrl(path), headers: _headers(headers));
  }

  static Future<Response> post(String path, body, {Map<String, String> headers}) async {
    return await Client().post(await _getServerUrl(path), body: json.encode(body), headers: _headers(headers));
  }

  static Future<Response> put(String path, body, {Map<String, String> headers}) async {
    return await Client().put(await _getServerUrl(path), body: json.encode(body), headers: _headers(headers));
  }

  static Future<Response> patch(String path, body, {Map<String, String> headers}) async {
    return await Client().patch(await _getServerUrl(path), body: json.encode(body), headers: _headers(headers));
  }

  static Future<Response> delete(String path, {Map<String, String> headers}) async {
    return await Client().delete(await _getServerUrl(path), headers: _headers(headers));
  }
}
