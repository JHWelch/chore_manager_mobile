import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/constants/keys.dart';
import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';
import '../mocks/secure_storage_mocks.dart';

void main() {
  group('user has never logged in', () {
    setUp(() {
      mockGlobals();
      mockAuthTokenStorage(null);
    });
    test('secure storage is called', () async {
      await Get.put(AuthController()).setup();

      verify(() => Globals.storage.read(key: authTokenKey));
    });
  });
}
