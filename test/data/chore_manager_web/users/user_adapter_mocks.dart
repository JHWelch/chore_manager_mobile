import 'dart:convert';

import 'package:http/http.dart';
import '../../../mocks/http_mocks.dart';

void mockAuthUserGet() => mockGet(
    path: 'auth_user',
    response: Response(
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
