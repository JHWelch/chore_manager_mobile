import 'package:chore_manager_mobile/data/common/reponse_type.dart';
import 'package:http/http.dart' as http;

class LoginResponse {
  late final ResponseType responseType;
  late final String? authToken;

  LoginResponse.fromHttpResponse(http.Response response) {
    if (response.statusCode == 200) {
      responseType = ResponseType.success;
      authToken = response.body;
    } else {
      responseType = ResponseType.failure;
    }
  }

  bool get isSuccess => responseType == ResponseType.success;
}
