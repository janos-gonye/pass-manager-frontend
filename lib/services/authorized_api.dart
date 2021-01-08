import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:pass_manager_frontend/services/api.dart';
import 'package:pass_manager_frontend/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:pass_manager_frontend/services/exceptions.dart' as exceptions;
import 'package:pass_manager_frontend/main.dart' as app;
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/services/interceptors.dart';
import 'package:pass_manager_frontend/services/policies.dart';

class AuthorizedApiService extends ApiService {
  http.Client client = HttpClientWithInterceptor.build(
    interceptors: [
      ContentTypeJsonInterceptor(),
      AuthenticationInterceptor(),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(),
    requestTimeout: constants.requestTimeout,
  );

  @override
  Future<http.Response> handleResponse(http.Response response) {
    if (200 <= response.statusCode && response.statusCode < 300) {
      return Future.delayed(Duration(seconds: 0), () => response);
    } else if (response.statusCode == 401) {
      AuthService().logout();
      app.navigatorKey.currentState.pushNamedAndRemoveUntil(
          constants.ROUTE_LOGIN, (route) => false,
          arguments: {"message": "Session expired."});
      return Future.error(exceptions.ApiException(""));
    } else if (response.statusCode == 500) {
      return Future.error(
          exceptions.InternalServerErrorException('Internal server error'));
    } else {
      return new Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    }
  }
}
