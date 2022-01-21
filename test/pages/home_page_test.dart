import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/widget_wrapper.dart';
import '../mocks/data_mocks/chore_mocks.dart';
import '../mocks/mocks.dart';

void main() {
  group('user has chores', () {
    setUp(() async {
      await givenLoggedIn();
      mockChoreIndex();
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
