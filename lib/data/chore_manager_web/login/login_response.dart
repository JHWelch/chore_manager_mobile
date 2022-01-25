import 'dart:convert';

import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/reponse_type.dart';
import 'package:chore_manager_mobile/modules/login/auth_user.dart';
import 'package:http/http.dart' as http;

class LoginResponse {
  late final ResponseType responseType;
  late final String? authToken;
  late final ApiErrors? errors;
  late final AuthUser user;

  LoginResponse.fromHttpResponse(http.Response response) {
    if (response.statusCode == 200) {
      responseType = ResponseType.success;
      final json = jsonDecode(response.body);
      authToken = json['token'];
      user = AuthUser.fromJson(json['user']);
    } else {
      responseType = ResponseType.failure;
      errors = ApiErrors.fromHttpResponse(response);
    }
  }

  bool get isSuccess => responseType == ResponseType.success;

  String? get firstError => errors?.errors?.first.messages.first;
}
