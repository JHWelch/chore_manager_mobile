import 'dart:convert';

import 'package:chore_manager_mobile/data/chore_manager_web/users/users_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../../../mocks/http_mocks.dart';
import '../../../mocks/mocks.dart';

void main() {
  group('show self', () {
    setUp(() {
      givenLoggedIn();
      mockGet(
          'auth_user',
          http.Response(
            jsonEncode({
              'user': {
                'id': 1,
                'name': 'John Smith',
                'email': 'jsmith@example.com',
                'profile_photo_path':
                    'https://randomuser.me/api/portraits/men/81.jpg',
                'current_team_id': 1,
              }
            }),
            200,
          ));
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
