import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/constants/keys.dart';
import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

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
        mockFirebaseOnTokenRefreshNoRun();
      });

      test('auth token is set', () async {
        final auth = await AuthService().init();
        await auth.onInit();

        expect(auth.authToken(), mockTokenString);
      });
    });
  });

  group('logout', () {
    AuthService? auth;

    setUp(() async {
      await givenLoggedIn();
      mockAuthTokenDelete();
      auth = Get.find<AuthService>();
    });

    test('auth token is set to ""', () async {
      await auth!.logout();

      expect(auth!.authToken(), '');
    });

    test('user is set to null', () async {
      await auth!.logout();

      expect(auth!.user(), null);
    });

    test('auth token is deleted', () async {
      await auth!.logout();

      verify(() => Globals.storage.delete(key: authTokenKey)).called(1);
    });
  });
}
