import 'package:http/http.dart' as http;

import '../http_mocks.dart';

void mockChoreIndex() {
  const String json = '''
        {
            "data": [
                {
                    "id": 1,
                    "user_id": 1,
                    "title": "Do the dishes",
                    "description": null,
                    "team_id": 1,
                    "frequency_id": 1,
                    "frequency_interval": 1,
                    "frequency_day_of": null,
                    "created_at": "2022-01-12T03:37:05.000000Z",
                    "updated_at": "2022-01-12T03:37:05.000000Z",
                    "next_due_date": "2022-02-23",
                    "due_date_updated_at": "2022-01-19T16:33:05.000000Z"
                },
                {
                    "id": 2,
                    "user_id": 1,
                    "title": "Take out the trash",
                    "description": null,
                    "team_id": 1,
                    "frequency_id": 2,
                    "frequency_interval": 1,
                    "frequency_day_of": null,
                    "created_at": "2022-01-12T03:37:05.000000Z",
                    "updated_at": "2022-01-12T03:37:05.000000Z",
                    "next_due_date": null,
                    "due_date_updated_at": null
                }
            ]
        }
      ''';

  mockGet('chores', http.Response(json, 200));
}
