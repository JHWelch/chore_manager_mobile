import 'package:chore_manager_mobile/extensions/date_time_formatting.dart';
import 'package:faker/faker.dart';

abstract class Factory<T> {
  Map<String, dynamic> properties = {};

  T build();

  List<T> listOf(int times) {
    final List<T> list = [];
    for (var i = 0; i < times; i++) {
      list.add(build());
    }
    return list;
  }

  Factory<T> state(Map<String, dynamic> properties) {
    this.properties = {
      ...this.properties,
      ...properties,
    };

    return this;
  }

  dynamic getProperty(String propertyName, dynamic defaultValue) =>
      properties.containsKey(propertyName)
          ? properties[propertyName]
          : defaultValue;

  /// Additional Fakers
  DateTime date() => faker.date.dateTime().toStartOfDay();
}
