import 'package:chore_manager_mobile/data/common/api_errors.dart';
import 'package:chore_manager_mobile/data/common/reponse_type.dart';
import 'package:http/http.dart' as http;

class LoginResponse {
  late final ResponseType responseType;
  late final String? authToken;
  late final ApiErrors? errors;

  LoginResponse.fromHttpResponse(http.Response response) {
    if (response.statusCode == 200) {
      responseType = ResponseType.success;
      authToken = response.body;
    } else {
      responseType = ResponseType.failure;
      errors = ApiErrors.fromHttpResponse(response);
    }
  }

  bool get isSuccess => responseType == ResponseType.success;

  String? get firstError => errors?.errors.first.messages.first;
}
