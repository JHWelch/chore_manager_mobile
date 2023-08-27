import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/constants/keys.dart';
import 'package:mocktail/mocktail.dart';

void mockAuthTokenStorage(String? token) =>
    mockSecureStorageRead(authTokenKey, token);

void mockAuthTokenWrite(String token) =>
    mockSecureStorageWrite(authTokenKey, token);

void mockAuthTokenDelete() => mockSecureStorageDelete(authTokenKey);

void mockSecureStorageWrite(String key, String value) {
  when(() => storage.write(key: key, value: value)).thenAnswer((_) async => {});
}

void mockSecureStorageRead(String key, String? value) {
  when(() => storage.read(key: key)).thenAnswer((_) async => value);
}

void mockSecureStorageDelete(String key) {
  when(() => storage.delete(key: key)).thenAnswer((_) async => {});
}
