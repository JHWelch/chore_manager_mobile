import 'dart:convert';

import 'package:chore_manager_mobile/config/config.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login_request.dart';
import 'package:http/http.dart' as http;

class LoginAdapter {
  Future<void> logIn(LoginRequest loginRequest) async {
    final http.Response response = await Globals.client.post(
      Uri.parse('${apiUrl}token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': loginRequest.email,
        'password': loginRequest.password,
        'device_name': 'Flutter App'
      }),
    );
  }
}
