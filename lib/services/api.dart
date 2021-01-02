import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pass_manager_frontend/services/settings.dart';

class ApiService {
  Future<Uri> _getServerUrl(String path) async {
    Uri url = await SettingsService.getServerUrl();
    return url.replace(path: path);
  }

  @protected
  Future<Map<String, String>> extendHeaders(Map<String, String> headers) async {
    headers = headers ?? {};
    headers["Content-Type"] = "application/json";
    headers["Accept"] = "application/json";
    return headers;
  }

  Future<Response> get(String path, {Map<String, String> headers}) async {
    return await Client()
        .get(await _getServerUrl(path), headers: await extendHeaders(headers));
  }

  Future<Response> post(String path, body,
      {Map<String, String> headers}) async {
    return await Client().post(await _getServerUrl(path),
        body: json.encode(body), headers: await extendHeaders(headers));
  }

  Future<Response> put(String path, body, {Map<String, String> headers}) async {
    return await Client().put(await _getServerUrl(path),
        body: json.encode(body), headers: await extendHeaders(headers));
  }

  Future<Response> patch(String path, body,
      {Map<String, String> headers}) async {
    return await Client().patch(await _getServerUrl(path),
        body: json.encode(body), headers: await extendHeaders(headers));
  }

  Future<Response> delete(String path, {Map<String, String> headers}) async {
    return await Client().delete(await _getServerUrl(path),
        headers: await extendHeaders(headers));
  }
}
