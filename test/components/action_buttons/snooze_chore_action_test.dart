import 'package:chore_manager_mobile/components/action_buttons/snooze_chore_action.dart';
import 'package:chore_manager_mobile/constants/strings.dart';
import 'package:chore_manager_mobile/extensions/date_time_ext.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../factories/chore_factory.dart';
import '../../helpers/helpers.dart';
import '../../mocks/data_mocks/chore_mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late Chore chore;

  setUp(() async {
    await givenLoggedIn();
    chore = ChoreFactory().build();
  });

  tearDown(Get.reset);

  void _setupController() {
    mockChoreIndex(chores: [chore]);
    Get.put(ChoresController());
  }

  void _mockSnoozeCalls(Chore chore, DateTime date) {
    mockChoreIndex(chores: [chore]);
    mockChoreSnooze(chore: chore, date: date);
  }

  testWidgets('has proper widget structure', (tester) async {
    _setupController();
    await tester.pumpWidget(WidgetWrapper(SnoozeChoreAction(choreId: 1)));

    expect(find.byIcon(Icons.access_time), findsOneWidget);
    expect(find.byTooltip(Strings.snooze), findsOneWidget);
  });

  testWidgets('clicking button shows snooze options', (tester) async {
    _setupController();
    await tester.pumpWidget(WidgetWrapper(SnoozeChoreAction(
      choreId: chore.id,
    )));

    await tester.tap(find.byType(PopupMenuButton));
    await tester.pump();

    expect(find.text(Strings.tomorrowTitle), findsOneWidget);
    expect(find.text(Strings.weekendTitle), findsOneWidget);
  });

  group('snooze until tomorrow', () {
    testWidgets('snoozes chore to endpoint', (tester) async {
      _setupController();
      final date = DateTimeExt.now().add(const Duration(days: 1));
      await tester.pumpWidget(WidgetWrapper(SnoozeChoreAction(
        choreId: chore.id,
      )));
      _mockSnoozeCalls(chore, date);

      await tester.tap(find.byType(PopupMenuButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text(Strings.tomorrowTitle));

      verifyChoreSnooze(chore: chore, date: date);
    });
  });

  group('snooze until weekend', () {
    testWidgets('snoozes chore to endpoint', (tester) async {
      _setupController();
      DateTimeExt.mockTime = DateTime(2023, 3, 15); // Known wednesday
      final date = DateTime(2023, 3, 18); // Saturday
      await tester.pumpWidget(WidgetWrapper(SnoozeChoreAction(
        choreId: chore.id,
      )));
      _mockSnoozeCalls(chore, date);

      await tester.tap(find.byType(PopupMenuButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text(Strings.weekendTitle));

      verifyChoreSnooze(chore: chore, date: date);
    });

    testWidgets('on weekend, snoozes until next weekend', (tester) async {
      _setupController();
      DateTimeExt.mockTime = DateTime(2023, 3, 18); // Known Saturday
      final date = DateTime(2023, 3, 25); // Next Saturday
      await tester.pumpWidget(WidgetWrapper(SnoozeChoreAction(
        choreId: chore.id,
      )));
      _mockSnoozeCalls(chore, date);

      await tester.tap(find.byType(PopupMenuButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text(Strings.weekendTitle));

      verifyChoreSnooze(chore: chore, date: date);
    });
  });
}
