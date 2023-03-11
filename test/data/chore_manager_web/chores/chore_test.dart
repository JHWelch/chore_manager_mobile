import 'dart:convert';

import 'package:chore_manager_mobile/constants/strings.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:chore_manager_mobile/modules/chores/frequency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../../../factories/chore_factory.dart';

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
          "next_due_user_id": 1,
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
    expect(chore.frequency.id, 2);
    expect(chore.frequencyInterval, 1);
    expect(chore.frequencyDayOf, 3);
    expect(chore.createdAt, DateTime.utc(2022, 01, 12, 03, 37, 05));
    expect(chore.updatedAt, DateTime.utc(2022, 01, 12, 03, 37, 05));
    expect(chore.nextDueUserId, 1);
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
      frequency: Frequency.fromId(2),
      frequencyInterval: 1,
      frequencyDayOf: 3,
      createdAt: DateTime.utc(2022, 01, 12, 03, 37, 05),
      updatedAt: DateTime.utc(2022, 01, 12, 03, 37, 05),
      nextDueUserId: 1,
      nextDueDate: DateTime(2022, 2, 23),
      dueDateUpdatedAt: DateTime.utc(2022, 1, 19, 16, 33, 5),
    );

    expect(chore.toJsonString(), _json.replaceAll(spacesOutsideQuotes, ''));
  });

  group('friendlyDueDate', () {
    test('for today', () {
      final chore = ChoreFactory().state({
        'nextDueDate': DateTime.now(),
      }).build();

      expect(Strings.today, chore.friendlyDueDate);
    });

    test('for tomorrow', () {
      final chore = ChoreFactory().state({
        'nextDueDate': DateTime.now().add(const Duration(days: 1)),
      }).build();

      expect(Strings.tomorrow, chore.friendlyDueDate);
    });

    test('as day name for days between +2 and +6', () {
      final dayPlus2 = DateTime.now().add(const Duration(days: 2));
      final dayPlus6 = DateTime.now().add(const Duration(days: 6));
      final chore1 = ChoreFactory().state({'nextDueDate': dayPlus2}).build();
      final chore2 = ChoreFactory().state({'nextDueDate': dayPlus6}).build();

      final dayPlus2String = DateFormat(DateFormat.WEEKDAY).format(dayPlus2);
      final dayPlus6String = DateFormat(DateFormat.WEEKDAY).format(dayPlus6);
      expect(chore1.friendlyDueDate, dayPlus2String);
      expect(chore2.friendlyDueDate, dayPlus6String);
    });

    test('see date formatted for day 7 on', () {
      final day = DateTime.now().add(const Duration(days: 7));
      final chore = ChoreFactory().state({'nextDueDate': day}).build();

      final dayString = DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(day);
      expect(dayString, chore.friendlyDueDate);
    });
  });

  group('friendlyFrequency', () {
    test('for daily', () {
      final chore = ChoreFactory().state({
        'frequency': Frequency.daily,
      }).build();

      expect('daily', chore.friendlyFrequency);
    });

    test('for weekly', () {
      final chore = ChoreFactory().state({
        'frequency': Frequency.weekly,
      }).build();

      expect('weekly', chore.friendlyFrequency);
    });

    test('for monthly', () {
      final chore = ChoreFactory().state({
        'frequency': Frequency.monthly,
      }).build();

      expect('monthly', chore.friendlyFrequency);
    });

    test('for yearly', () {
      final chore = ChoreFactory().state({
        'frequency': Frequency.yearly,
      }).build();

      expect('yearly', chore.friendlyFrequency);
    });
  });
}
