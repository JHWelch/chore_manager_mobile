import 'dart:convert';

import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/device_tokens/device_tokens_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../mocks/http_mocks.dart';
import '../../../mocks/mocks.dart';

void main() {
  setUp(givenLoggedIn);

  group('store', () {
    test('can send device token', () async {
      const token = 'token';
      mockPost(
        path: 'device_tokens',
        body: jsonEncode({'token': token}),
        response: http.Response('[]', 201),
      );

      await DeviceTokensAdapter().store(token: token);

      verify(() => Globals.client.post(
            expectedPath('device_tokens'),
            headers: expectedHeaders(),
            body: jsonEncode({'token': token}),
          ));
    });
  });
}
