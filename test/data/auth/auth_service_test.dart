import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../mocks/firebase_mocks.dart';
import '../../mocks/http_mocks.dart';
import '../../mocks/mocks.dart';
import '../../mocks/secure_storage_mocks.dart';
import '../chore_manager_web/users/user_adapter_mocks.dart';

void main() {
  setUp(mockGlobals);

  group('init', () {
    group('user has never logged in', () {
      setUp(() {
        mockAuthTokenStorage(null);
      });

      test('auth token is set to ""', () async {
        final auth = await Get.putAsync(AuthService().init);

        expect(auth.authToken(), '');
      });
    });

    group('user has logged in', () {
      setUp(() {
        mockAuthTokenStorage(mockTokenString);
        mockAuthUserGet();
        mockFirebaseGetToken(null);
      });

      test('auth token is set', () async {
        final auth = await Get.putAsync(AuthService().init);

        expect(auth.authToken(), mockTokenString);
      });
    });
  });
}
