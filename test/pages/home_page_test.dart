import 'dart:convert';

import 'package:chore_manager_mobile/components/spinner.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/constants/strings.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import '../factories/chore_factory.dart';
import '../helpers/helpers.dart';
import '../mocks/data_mocks/chore_mocks.dart';
import '../mocks/http_mocks.dart';
import '../mocks/mocks.dart';

void main() {
  group('user has chores', () {
    setUp(() async {
      await givenLoggedIn();
    });

    tearDown(Get.reset);

    group('user sees chores with due date', () {
      testWidgets('', (tester) async {
        final chores = ChoreFactory().listOf(3);
        mockChoreIndex(chores: chores);
        await tester.pumpWidget(WidgetWrapper(HomePage()));

        for (final chore in chores) {
          expect(find.text(chore.title), findsOneWidget);
        }
      });

      testWidgets('for today', (tester) async {
        final chore = ChoreFactory().state({
          'nextDueDate': DateTime.now(),
        }).build();
        mockChoreIndex(chores: [chore]);
        await tester.pumpWidget(WidgetWrapper(HomePage()));

        expect(find.text('today'), findsOneWidget);
      });

      testWidgets('for tomorrow', (tester) async {
        final chore = ChoreFactory().state({
          'nextDueDate': DateTime.now().add(const Duration(days: 1)),
        }).build();
        mockChoreIndex(chores: [chore]);
        await tester.pumpWidget(WidgetWrapper(HomePage()));

        expect(find.text('tomorrow'), findsOneWidget);
      });

      testWidgets('as day name for days between +2 and +6', (tester) async {
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

      testWidgets('see date formatted for day 7 on', (tester) async {
        final day = DateTime.now().add(const Duration(days: 7));
        final chore = ChoreFactory().state({'nextDueDate': day}).build();

        mockChoreIndex(chores: [chore]);
        await tester.pumpWidget(WidgetWrapper(HomePage()));

        final dayString = DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(day);
        expect(find.text(dayString), findsOneWidget);
      });
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

    group('tap refresh button', () {
      setUp(mockChoreIndex);

      Future<void> clickRefreshButton(WidgetTester tester) async {
        await tester.tap(find.byIcon(Icons.refresh));
      }

      testWidgets('user can refresh to see new chores', (tester) async {
        await tester.pumpWidget(WidgetWrapper(HomePage()));

        final chores = ChoreFactory().listOf(3);
        mockChoreIndex(chores: chores);

        await clickRefreshButton(tester);
        await tester.pumpAndSettle();

        for (final chore in chores) {
          expect(find.text(chore.title), findsOneWidget);
        }
      });

      testWidgets('refresh icon spins and tooltip changes', (tester) async {
        await tester.pumpWidget(WidgetWrapper(HomePage()));

        final chores = ChoreFactory().listOf(3);
        mockChoreIndex(chores: chores, delay: const Duration(seconds: 2));

        await clickRefreshButton(tester);
        await tester.pump(const Duration(seconds: 1));

        expect(find.byType(Spinner), findsOneWidget);
        expect(find.byTooltip(Strings.refreshingChores), findsOneWidget);
        await tester.pumpAndSettle();
        expect(find.byType(Spinner), findsNothing);
        expect(find.byTooltip(Strings.refreshChores), findsOneWidget);
      });
    });

    group('tap complete on a chore', () {
      late Chore chore;

      setUp(() {
        chore = ChoreFactory().build();
        mockChoreIndex(chores: [chore]);
      });

      testWidgets('chore line is dismissed', (tester) async {
        await tester.pumpWidget(WidgetWrapper(HomePage()));
        mockChoreComplete(chore: chore);
        mockChoreIndex(chores: [ChoreFactory().build()]);
        final dismissible = find.widgetWithText(Dismissible, chore.title);

        expect(dismissible, findsOneWidget);

        await tester.dismiss(dismissible);
        await tester.pumpAndSettle();

        expect(dismissible, findsNothing);
      });

      testWidgets('chore is marked completed', (tester) async {
        await tester.pumpWidget(WidgetWrapper(HomePage()));
        mockChoreComplete(chore: chore);
        mockChoreIndex(chores: [ChoreFactory().build()]);
        final dismissible = find.byType(Dismissible);

        await tester.dismiss(dismissible);
        await tester.pumpAndSettle();

        verify(() => Globals.client.patch(
              expectedPath('chores/${chore.id}'),
              headers: expectedHeaders(),
              body: jsonEncode({'completed': true}),
            ));
      });

      testWidgets('chore list is refreshed with new chores', (tester) async {
        await tester.pumpWidget(WidgetWrapper(HomePage()));
        mockChoreComplete(chore: chore);
        final newChore = ChoreFactory().build();
        mockChoreIndex(chores: [newChore]);
        final dismissible = find.byType(Dismissible);

        await tester.dismiss(dismissible);
        await tester.pumpAndSettle();

        expect(find.text(newChore.title), findsOneWidget);
      });
    });
  });
}
