import 'package:chore_manager_mobile/config/config.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

const String mockTokenString = 'TOKEN_STRING_HERE';

void mockGet(
  String path,
  http.Response response, [
  Map<String, String>? headers,
]) {
  when(
    () => Globals.client.get(
      expectedPath(path),
      headers: headers ?? expectedHeaders(),
    ),
  ).thenAnswer((_) async => response);
}

void mockPost(
  String path,
  http.Response response,
  String body, [
  Map<String, String>? headers,
]) {
  when(
    () => Globals.client.post(
      expectedPath(path),
      headers: headers ?? expectedHeaders(),
      body: body,
    ),
  ).thenAnswer((_) async => response);
}

Uri expectedPath(String path) {
  return Uri.parse(apiUrl + path);
}

Map<String, String> expectedHeaders() {
  return {
    'Accept': 'application/json',
    'Authorization': 'Bearer $mockTokenString',
    'Content-Type': 'application/json; charset=UTF-8',
  };
}

Map<String, String> expectedAuthHeaders() {
  return {
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
