import 'package:http_interceptor/models/models.dart';
import 'package:http_interceptor/models/retry_policy.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      return true;
    }

    return false;
  }
}
