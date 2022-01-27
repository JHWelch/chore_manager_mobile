import 'dart:convert';

import 'package:chore_manager_mobile/data/chore_manager_web/common/api_response.dart';
import 'package:chore_manager_mobile/modules/login/auth_user.dart';
import 'package:http/http.dart';

class AuthUserResponse extends ApiResponse {
  late final AuthUser user;
  AuthUserResponse.fromHttpResponse(Response response)
      : super.fromHttpResponse(response) {
    user = AuthUser.fromJson(jsonDecode(response.body)['user']);
  }
}
