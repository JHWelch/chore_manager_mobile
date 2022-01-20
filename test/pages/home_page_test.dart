import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../helpers/widget_wrapper.dart';
import '../mocks/http_mocks.dart';
import '../mocks/mocks.dart';

void main() {
  group('user has chores', () {
    setUp(() async {
      await givenLoggedIn();
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
    });

    testWidgets('user sees chores with due dates', (tester) async {
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      expect(find.text('Do the dishes'), findsOneWidget);
    });

    // testWidgets('user does not see chores with no due dates', (tester) async {
    //   await tester.pumpWidget(WidgetWrapper(HomePage()));

    //   expect(find.text('Take out the trash'), findsNothing);
    // });
  });
}
