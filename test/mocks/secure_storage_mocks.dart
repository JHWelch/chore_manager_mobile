import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/constants/keys.dart';
import 'package:mocktail/mocktail.dart';

void mockAuthTokenStorage(String? token) {
  when(() => Globals.storage.read(key: authTokenKey))
      .thenAnswer((_) => Future(() => token));
}
