import 'dart:convert';

import 'package:chore_manager_mobile/config/config.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:http/http.dart' as http;

class NetworkAdapter {
  String? token;

  NetworkAdapter({this.token});

  Future<http.Response> get({
    required String uri,
    Map<String, String>? headers,
  }) =>
      Globals.client.get(
        url(uri),
        headers: headers ?? defaultHeaders,
      );

  Future<http.Response> post({
    required String uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) =>
      Globals.client.post(
        url(uri),
        headers: headers ?? defaultHeaders,
        body: jsonEncode(body),
      );

  Uri url(String uri) => Uri.parse('$apiUrl$uri');

  Map<String, String> get defaultHeaders => {
        'Authorization': 'Bearer $token',
        ...unauthedHeaders,
      };

  Map<String, String> get unauthedHeaders => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
}
