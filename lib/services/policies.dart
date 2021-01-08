import 'package:http_interceptor/models/models.dart';
import 'package:http_interceptor/models/retry_policy.dart';
import 'package:pass_manager_frontend/services/auth.dart';
import 'package:pass_manager_frontend/services/exceptions.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401 && AuthService.refreshToken != null) {
      try {
        await AuthService().refreshAccesToken();
        return true;
      } on ApiException {
        return false;
      }
    }
    return false;
  }
}
