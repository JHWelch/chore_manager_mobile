import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/constants/keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

void givenNotLoggedIn() {
  mockGlobals();
  mockUserToken(null);
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
