import 'package:flutter_test/flutter_test.dart';

extension CustomWidgetTester on WidgetTester {
  Future<void> dismiss(Finder dismissible) =>
      drag(dismissible, const Offset(500, 0));
}
