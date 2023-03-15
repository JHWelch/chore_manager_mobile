import 'package:chore_manager_mobile/components/action_buttons/complete_chore_action.dart';
import 'package:chore_manager_mobile/constants/strings.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

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

  void _mockCompleteCalls(Chore chore) {
    mockChoreIndex(chores: [chore]);
    mockChoreComplete(chore: chore);
  }

  testWidgets('has proper widget structure', (tester) async {
    _setupController();
    await tester.pumpWidget(WidgetWrapper(CompleteChoreAction(choreId: 1)));

    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(find.byTooltip(Strings.complete), findsOneWidget);
  });

  testWidgets('calls completeChore on controller', (tester) async {
    _setupController();
    await tester.pumpWidget(WidgetWrapper(CompleteChoreAction(
      choreId: chore.id,
    )));
    _mockCompleteCalls(chore);

    await tester.tap(find.byType(IconButton));

    verifyChoreComplete(chore);
  });

  testWidgets('calls callback after completion', (tester) async {
    _setupController();
    final callback = FunctionVerifier();
    await tester.pumpWidget(WidgetWrapper(CompleteChoreAction(
      choreId: chore.id,
      postComplete: callback.functionCall,
    )));
    _mockCompleteCalls(chore);

    await tester.tap(find.byType(IconButton));

    verify(callback.functionCall).called(1);
  });
}
