import 'dart:convert';

import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const String _json = '''
    {
          "id": 1,
          "user_id": 1,
          "title": "Do the dishes",
          "description": "This is the description.",
          "team_id": 1,
          "frequency_id": 2,
          "frequency_interval": 1,
          "frequency_day_of": 3,
          "created_at": "2022-01-12T03:37:05.000000Z",
          "updated_at": "2022-01-12T03:37:05.000000Z",
          "next_due_date": "2022-02-23",
          "due_date_updated_at": "2022-01-19T16:33:05.000000Z"
    }
    ''';

  final RegExp spacesOutsideQuotes =
      RegExp(r'\s(?=(?:[^"`]*(["`])[^"`]*\1)*[^"`]*$)');

  test('Can create chore from JSON', () {
    final chore = Chore.fromJson(jsonDecode(_json));
    expect(chore.id, 1);
    expect(chore.userId, 1);
    expect(chore.title, 'Do the dishes');
    expect(chore.description, 'This is the description.');
    expect(chore.teamId, 1);
    expect(chore.frequencyId, 2);
    expect(chore.frequencyInterval, 1);
    expect(chore.frequencyDayOf, 3);
    expect(chore.createdAt, DateTime.utc(2022, 01, 12, 03, 37, 05));
    expect(chore.updatedAt, DateTime.utc(2022, 01, 12, 03, 37, 05));
    expect(chore.nextDueDate, DateTime(2022, 2, 23));
    expect(chore.dueDateUpdatedAt, DateTime.utc(2022, 1, 19, 16, 33, 5));
  });

  test('Can get JSON from chore', () {
    final chore = Chore(
      id: 1,
      userId: 1,
      title: 'Do the dishes',
      description: 'This is the description.',
      teamId: 1,
      frequencyId: 2,
      frequencyInterval: 1,
      frequencyDayOf: 3,
      createdAt: DateTime.utc(2022, 01, 12, 03, 37, 05),
      updatedAt: DateTime.utc(2022, 01, 12, 03, 37, 05),
      nextDueDate: DateTime(2022, 2, 23),
      dueDateUpdatedAt: DateTime.utc(2022, 1, 19, 16, 33, 5),
    );

    expect(chore.toJsonString(), _json.replaceAll(spacesOutsideQuotes, ''));
  });
}
