import 'dart:convert';

import 'package:chore_manager_mobile/config/config.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_response.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;

class NetworkAdapter {
  late final AuthService auth;
  late final String? _token;

  NetworkAdapter({String? authToken}) {
    _token = authToken;

    if (authToken == null) {
      auth = Get.find();
    }
  }

  String get token => _token ?? auth.authToken();

  Future<ApiResponse> get({
    required String uri,
    required ApiResponse Function(http.Response) processSuccess,
    Map<String, String>? headers,
  }) async {
    final response = await client.get(
      url(uri),
      headers: headers ?? defaultHeaders,
    );

    return await parseErrors(response) ?? processSuccess(response);
  }

  Future<ApiResponse> post({
    required String uri,
    required ApiResponse Function(http.Response) processSuccess,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final response = await client.post(
      url(uri),
      headers: headers ?? defaultHeaders,
      body: jsonEncode(body),
    );

    return await parseErrors(response) ?? processSuccess(response);
  }

  Future<ApiResponse> patch({
    required String uri,
    required ApiResponse Function(http.Response) processSuccess,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final response = await client.patch(
      url(uri),
      headers: headers ?? defaultHeaders,
      body: jsonEncode(body),
    );

    return await parseErrors(response) ?? processSuccess(response);
  }

  Future<ApiErrors?> parseErrors(http.Response response) async {
    if (HttpStatus(response.statusCode).isOk) {
      return null;
    }

    final errors = ApiErrors.fromHttpResponse(response);

    if (errors.isAuthError && Get.currentRoute.isNotEmpty) {
      await Get.offAllNamed(Routes.login);
    }

    return errors;
  }

  Uri url(String uri) => Uri.parse('$apiUrl$uri');

  Map<String, String> get defaultHeaders => {
        'Authorization': 'Bearer $token',
        ...unauthedHeaders,
      };

  Map<String, String> get unauthedHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}
