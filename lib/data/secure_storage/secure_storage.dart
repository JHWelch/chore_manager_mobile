import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/constants/keys.dart';

Future<void> storeAuthToken(String? authToken) =>
    storage.write(key: authTokenKey, value: authToken);

Future<String?> retrieveAuthToken() => storage.read(key: authTokenKey);

Future<void> deleteAuthToken() => storage.delete(key: authTokenKey);
