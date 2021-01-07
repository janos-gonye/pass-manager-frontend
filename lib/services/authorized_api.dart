import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:pass_manager_frontend/services/api.dart';
import 'package:pass_manager_frontend/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:pass_manager_frontend/services/exceptions.dart' as exceptions;
import 'package:pass_manager_frontend/main.dart' as app;
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/services/interceptors.dart';

class AuthorizedApiService extends ApiService {
  http.Client client = HttpClientWithInterceptor.build(interceptors: [
    ContentTypeJsonInterceptor(),
    AuthenticationInterceptor(),
  ]);

  @override
  Future<http.Response> handleResponse(http.Response response) {
    if (200 <= response.statusCode && response.statusCode < 300) {
      return Future.delayed(Duration(seconds: 0), () => response);
    } else if (response.statusCode == 401) {
      AuthService.logout();
      app.navigatorKey.currentState.pushNamedAndRemoveUntil(
          constants.ROUTE_LOGIN, (route) => false,
          arguments: {"message": "Session expired."});
      throw new exceptions.ApiException("");
    } else if (response.statusCode == 500) {
      throw new exceptions.InternalServerErrorException(
          'Internal server error');
    } else {
      throw new exceptions.ApiException('Error when connecting to the server');
    }
  }
}
