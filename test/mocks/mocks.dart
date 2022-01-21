import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/constants/keys.dart';
import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'http_mocks.dart';

Future<void> givenNotLoggedIn() async {
  mockGlobals();
  mockUserToken(null);
  await mockPermanentControllers();
}

Future<void> givenLoggedIn() async {
  mockGlobals();
  mockUserToken(mockTokenString);
  await mockPermanentControllers();
}

Future<void> mockPermanentControllers() async {
  final AuthController auth = Get.put(AuthController(), permanent: true);
  await auth.setup();
}

void mockGlobals() {
  Globals.client = MockClient();
  Globals.storage = MockFlutterSecureStorage();
}

void mockUserToken(String? token) {
  _mockSecureStorageRead(authTokenKey, token);
}

void _mockSecureStorageRead(String key, String? value) {
  when(
    () => Globals.storage.read(key: key),
  ).thenAnswer((_) async => value);
}

/// Mock Classes
class MockClient extends Mock implements http.Client {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
