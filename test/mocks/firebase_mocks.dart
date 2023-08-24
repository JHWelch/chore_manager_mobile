import 'package:chore_manager_mobile/config/globals.dart';
import 'package:mocktail/mocktail.dart';

void mockFirebaseGetToken(String? token) {
  when(() => Globals.firebase.getToken()).thenAnswer((_) async => token);
}
