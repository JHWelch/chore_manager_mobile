import 'package:chore_manager_mobile/extensions/date_time_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mockTime', () {
    tearDown(DateTimeExt.resetMockTime);

    test('when set, DateTimeExt.now() returns mockTime', () {
      final DateTime mockTime = DateTime(2021, 1, 1);
      DateTimeExt.mockTime = mockTime;

      expect(DateTimeExt.now(), mockTime);
    });

    test('when not set, DateTimeExt.now() = DateTime.now()', () {
      // Only comparing dates because the time will be slightly different
      expect(DateTimeExt.now().toDateString(), DateTime.now().toDateString());
    });
  });

  group('nextWeekend', () {
    group('weekday', () {
      test('returns the next saturday', () {
        final DateTime monday = DateTime(2023, 3, 13);
        final DateTime tuesday = DateTime(2023, 3, 14);
        final DateTime wednesday = DateTime(2023, 3, 15);
        final DateTime thursday = DateTime(2023, 3, 16);
        final DateTime friday = DateTime(2023, 3, 17);

        expect(monday.nextWeekend(), DateTime(2023, 3, 18));
        expect(tuesday.nextWeekend(), DateTime(2023, 3, 18));
        expect(wednesday.nextWeekend(), DateTime(2023, 3, 18));
        expect(thursday.nextWeekend(), DateTime(2023, 3, 18));
        expect(friday.nextWeekend(), DateTime(2023, 3, 18));
      });
    });

    group('weekend', () {
      test('returns the next saturday', () {
        final DateTime saturday = DateTime(2023, 3, 18);
        final DateTime sunday = DateTime(2023, 3, 19);

        expect(saturday.nextWeekend(), DateTime(2023, 3, 25));
        expect(sunday.nextWeekend(), DateTime(2023, 3, 25));
      });
    });
  });
}
