import 'package:chore_manager_mobile/components/action_buttons/snooze_chore_action.dart';
import 'package:chore_manager_mobile/constants/strings.dart';
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
}