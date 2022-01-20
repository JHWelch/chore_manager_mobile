import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/constants/keys.dart';

Future<void> storeAuthToken(String? authToken) =>
    Globals.storage.write(key: authTokenKey, value: authToken);

Future<String?> retrieveAuthToken() => Globals.storage.read(key: authTokenKey);
