import 'dart:convert';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../http_mocks.dart';

void mockDeviceTokenStore({required String token, required int statusCode}) {
  mockPost(
    path: 'device_tokens',
    body: jsonEncode({'token': token}),
    response: http.Response('[]', statusCode),
  );
}

void verifyDeviceTokenStore({required String token}) =>
    verify(() => Globals.client.post(
          expectedPath('device_tokens'),
          headers: expectedHeaders(),
          body: jsonEncode({'token': token}),
        ));
