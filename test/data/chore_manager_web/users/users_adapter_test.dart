import 'package:chore_manager_mobile/data/chore_manager_web/users/users_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/http_mocks.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/secure_storage_mocks.dart';
import 'user_adapter_mocks.dart';

void main() {
  group('show self', () {
    setUp(() {
      givenLoggedIn();
      mockAuthTokenStorage(mockTokenString);
      mockAuthUserGet();
    });

    test('user can get their own data', () async {
      final adapter = UsersAdapter();

      final user = await adapter.authUser();

      expect(user.id, 1);
      expect(user.name, 'John Smith');
      expect(user.email, 'jsmith@example.com');
      expect(user.profilePhotoPath,
          'https://randomuser.me/api/portraits/men/81.jpg');
      expect(user.currentTeamId, 1);
    });
  });
}
