import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:chore_manager_mobile/modules/login/auth_user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'http_mocks.dart';

Future<void> givenNotLoggedIn() async {
  mockGlobals();
  await mockServices(authed: false);
}

Future<void> givenLoggedIn() async {
  mockGlobals();
  await mockServices();
}

Future<void> mockServices({bool authed = true}) async {
  final auth = Get.put(AuthService());

  if (authed) {
    auth.user(AuthUser(
      id: 1,
      name: 'John Smith',
      email: 'jsmith@example.com',
      currentTeamId: 1,
    ));
    auth.authToken(mockTokenString);
  }
}

void mockGlobals() {
  Get.testMode = true;
  client = MockClient();
  storage = MockFlutterSecureStorage();
  firebase = MockFirebaseMessaging();
}

/// Mock Classes
class MockClient extends Mock implements http.Client {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}
