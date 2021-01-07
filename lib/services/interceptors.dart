import 'package:http_interceptor/http_interceptor.dart';
import 'package:pass_manager_frontend/services/auth.dart';

class ContentTypeJsonInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    data.headers['Content-Type'] = 'application/json';
    data.headers['Accept'] = 'application/json';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}

class AuthenticationInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    data.headers["Authorization"] = "Bearer ${await AuthService.accessToken}";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}
