import 'package:chore_manager_mobile/data/chore_manager_web/device_tokens/device_tokens_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/data_mocks/device_token_mocks.dart';
import '../../../mocks/mocks.dart';

void main() {
  setUp(givenLoggedIn);

  group('store', () {
    test('can create device token', () async {
      const token = 'token';
      mockDeviceTokenStore(token: token, statusCode: 201);

      await DeviceTokensAdapter().store(token: token);

      verifyDeviceTokenStore(token: token);
    });

    test('can update existing device token', () async {
      const token = 'token';
      mockDeviceTokenStore(token: token);

      await DeviceTokensAdapter().store(token: token);

      verifyDeviceTokenStore(token: token);
    });
  });
}
