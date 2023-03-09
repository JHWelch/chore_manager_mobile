import 'package:chore_manager_mobile/data/chore_manager_web/common/response_type.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;

class ApiResponse {
  late final ResponseType responseType;

  ApiResponse(this.responseType);

  ApiResponse.fromHttpResponse(http.Response response) {
    responseType = response.statusCode == HttpStatus.ok
        ? ResponseType.success
        : ResponseType.failure;
  }

  bool get isSuccess => responseType == ResponseType.success;
  bool get isFailure => responseType == ResponseType.failure;
}
