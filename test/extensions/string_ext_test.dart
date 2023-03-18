import 'package:chore_manager_mobile/extensions/string_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('capitalizeFirst', () {
    test('should capitalize first letter of a string', () {
      expect('hello'.capitalizeFirst, 'Hello');
    });

    test('capitalized strings remain the same', () {
      expect('Hello'.capitalizeFirst, 'Hello');
    });
  });
}
