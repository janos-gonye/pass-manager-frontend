import 'package:pass_manager_frontend/services/api.dart';
import 'package:pass_manager_frontend/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:pass_manager_frontend/services/exceptions.dart' as exceptions;
import 'package:pass_manager_frontend/main.dart' as app;
import 'package:pass_manager_frontend/constants.dart' as constants;

class AuthorizedApiService extends ApiService {
  @override
  Future<Map<String, String>> extendHeaders(Map<String, String> headers) async {
    headers = await super.extendHeaders(headers);
    headers["Authorization"] = "Bearer ${await AuthService.accessToken}";
    return headers;
  }

  @override
  Future<http.Response> handleResponse(http.Response response) {
    if (200 <= response.statusCode && response.statusCode < 300) {
      return Future.delayed(Duration(seconds: 0), () => response);
    } else if (response.statusCode == 401) {
      AuthService.logout();
      app.navigatorKey.currentState
          .pushNamedAndRemoveUntil(constants.ROUTE_LOGIN, (route) => false);
    } else if (response.statusCode == 500) {
      throw new exceptions.InternalServerErrorException(
          'Internal server error');
    } else {
      throw new exceptions.ApiException('Error when connecting to the server');
    }
  }
}
