import 'package:chore_manager_mobile/extensions/date_time_extension.dart';
import 'package:chore_manager_mobile/modules/chores/frequency.dart';
import 'package:faker/faker.dart';
export 'package:faker/faker.dart';

extension FakerExtension on Faker {
  DateTime startOfDay() => faker.date.dateTime().toStartOfDay();

  Frequency frequency() {
    final frequencies = List<Frequency>.from(Frequency.values)..shuffle();

    return frequencies.first;
  }
}
