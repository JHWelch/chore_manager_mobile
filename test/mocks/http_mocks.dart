import 'package:chore_manager_mobile/config/config.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

const String mockTokenString = 'TOKEN_STRING_HERE';

void mockGet({
  required String path,
  required http.Response response,
  Map<String, String>? headers,
  Duration? delay,
}) {
  when(() => Globals.client.get(
        expectedPath(path),
        headers: headers ?? expectedHeaders(),
      )).thenAnswer(delayedOrNot(response, delay));
}

Future<http.Response> Function(Invocation) delayedOrNot(
  http.Response response,
  Duration? delay,
) =>
    delay == null
        ? (_) async => response
        : (_) => Future.delayed(delay, () => response);

void mockPost({
  required String path,
  required http.Response response,
  required String body,
  Map<String, String>? headers,
}) {
  when(() => Globals.client.post(
        expectedPath(path),
        headers: headers ?? expectedHeaders(),
        body: body,
      )).thenAnswer((_) async => response);
}

void mockPatch({
  required String path,
  required http.Response response,
  required String body,
  Map<String, String>? headers,
}) {
  when(() => Globals.client.patch(
        expectedPath(path),
        headers: headers ?? expectedHeaders(),
        body: body,
      )).thenAnswer((_) async => response);
}

Uri expectedPath(String path) => Uri.parse(apiUrl + path);

Map<String, String> expectedHeaders() => {
      'Accept': 'application/json',
      'Authorization': 'Bearer $mockTokenString',
      'Content-Type': 'application/json',
    };

Map<String, String> expectedAuthHeaders() => {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
