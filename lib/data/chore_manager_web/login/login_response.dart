import 'dart:convert';

import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_response.dart';
import 'package:chore_manager_mobile/modules/login/auth_user.dart';
import 'package:http/http.dart' as http;

class LoginResponse extends ApiResponse {
  late final String? authToken;
  late final ApiErrors? errors;
  late final AuthUser user;

  LoginResponse.fromHttpResponse(http.Response response)
      : super.fromHttpResponse(response) {
    final json = jsonDecode(response.body);
    authToken = json['token'];
    user = AuthUser.fromJson(json['user']);
  }
}
