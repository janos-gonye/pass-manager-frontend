import 'package:pass_manager_frontend/services/api.dart';
import 'package:pass_manager_frontend/services/auth.dart';

class AuthorizedApiService extends ApiService {
  @override
  Future<Map<String, String>> extendHeaders(Map<String, String> headers) async {
    headers = await super.extendHeaders(headers);
    headers["Authorization"] = "Bearer ${await AuthRepository.accessToken}";
    return headers;
  }
}
