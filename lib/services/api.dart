import 'package:http/http.dart';
import 'package:pass_manager_frontend/services/settings.dart';

class ApiService {

  static Future<Uri> _getServerUrl(String path) async {
    Uri url = await SettingsService.getServerUrl();
    url.replace(path: path);
    return url;
  }

  static Future<Response> get(String path, {Map<String, String> headers}) {
    return Client().get(_getServerUrl(path), headers: headers);
  }

  static Future<Response> post(String path, body, {Map<String, String> headers}) {
    return Client().post(_getServerUrl(path), body: body, headers: headers);
  }

  static Future<Response> put(String path, body, {Map<String, String> headers}) {
    return Client().put(_getServerUrl(path), body: body, headers: headers);
  }

  static Future<Response> patch(String path, body, {Map<String, String> headers}) {
    return Client().patch(_getServerUrl(path), body: body, headers: headers);
  }

  static Future<Response> delete(String path, {Map<String, String> headers}) {
    return Client().delete(_getServerUrl(path), headers: headers);
  }
}
