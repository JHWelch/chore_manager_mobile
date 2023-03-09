import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../factories/chore_factory.dart';
import '../helpers/widget_wrapper.dart';
import '../mocks/data_mocks/chore_mocks.dart';
import '../mocks/mocks.dart';

void main() {
  group('user has chores', () {
    setUp(() async {
      await givenLoggedIn();
    });

    tearDown(Get.reset);

    testWidgets('user sees chores with due dates', (tester) async {
      final chores = ChoreFactory().listOf(3);
      mockChoreIndex(chores: chores);
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      for (final chore in chores) {
        expect(find.text(chore.title), findsOneWidget);
      }
    });

    testWidgets('user sees chore due date for today', (tester) async {
      final chore = ChoreFactory().state({
        'nextDueDate': DateTime.now(),
      }).build();
      mockChoreIndex(chores: [chore]);
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      expect(find.text('today'), findsOneWidget);
    });

    testWidgets('user sees chore due date for tomorrow', (tester) async {
      final chore = ChoreFactory().state({
        'nextDueDate': DateTime.now().add(const Duration(days: 1)),
      }).build();
      mockChoreIndex(chores: [chore]);
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      expect(find.text('tomorrow'), findsOneWidget);
    });

    testWidgets('for days between +2 and +6, see day name', (tester) async {
      final dayPlus2 = DateTime.now().add(const Duration(days: 2));
      final dayPlus6 = DateTime.now().add(const Duration(days: 6));
      final chore1 = ChoreFactory().state({'nextDueDate': dayPlus2}).build();
      final chore2 = ChoreFactory().state({'nextDueDate': dayPlus6}).build();

      mockChoreIndex(chores: [chore1, chore2]);
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      final dayPlus2String = DateFormat(DateFormat.WEEKDAY).format(dayPlus2);
      final dayPlus6String = DateFormat(DateFormat.WEEKDAY).format(dayPlus6);
      expect(find.text(dayPlus2String), findsOneWidget);
      expect(find.text(dayPlus6String), findsOneWidget);
    });

    testWidgets('for day 7 on, see date formatted', (tester) async {
      final day = DateTime.now().add(const Duration(days: 7));
      final chore = ChoreFactory().state({'nextDueDate': day}).build();

      mockChoreIndex(chores: [chore]);
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      final dayString = DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(day);
      expect(find.text(dayString), findsOneWidget);
    });

    testWidgets('user does not see chores with no due dates', (tester) async {
      final chores = ChoreFactory().withoutInstance().listOf(3);
      mockChoreIndex(chores: chores);
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      for (final chore in chores) {
        expect(find.text(chore.title), findsNothing);
      }
    });

    testWidgets('user does not see chores assigned to others', (tester) async {
      final chore = ChoreFactory().state({'nextDueUserId': 2}).build();
      mockChoreIndex(chores: [chore]);
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      expect(find.text(chore.title), findsNothing);
    });

    testWidgets('user can refresh to see new chores', (tester) async {
      mockChoreIndex();
      await tester.pumpWidget(WidgetWrapper(HomePage()));

      final chores = ChoreFactory().listOf(3);
      mockChoreIndex(chores: chores);

      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pumpAndSettle();

      for (final chore in chores) {
        expect(find.text(chore.title), findsOneWidget);
      }
    });

    group('tap complete on a chore', () {
      late Chore chore;

      setUp(() {
        chore = ChoreFactory().build();
        mockChoreIndex(chores: [chore]);
      });

      testWidgets('chore line is dismissed', (tester) async {
        await tester.pumpWidget(WidgetWrapper(HomePage()));
        final dismissible = find.byType(Dismissible);

        expect(dismissible, findsOneWidget);

        await tester.drag(dismissible, const Offset(500, 0));
        await tester.pumpAndSettle();

        expect(dismissible, findsNothing);
      });
    });
  });
}
