import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../factories/chore_factory.dart';
import '../helpers/widget_wrapper.dart';
import '../mocks/data_mocks/chore_mocks.dart';
import '../mocks/mocks.dart';

void main() {
  group('user has chores', () {
    setUp(() async {
      await givenLoggedIn();
    });

    testWidgets('user sees chores with due dates', (tester) async {
      final chores = ChoreFactory().listOf(3);
      mockChoreIndex(chores: chores);
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      for (final chore in chores) {
        expect(find.text(chore.title), findsOneWidget);
      }
    });

    testWidgets('user does not see chores with no due dates', (tester) async {
      final chores = ChoreFactory().withoutInstance().listOf(3);
      mockChoreIndex(chores: chores);
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      for (final chore in chores) {
        expect(find.text(chore.title), findsNothing);
      }
    });
  });
}
