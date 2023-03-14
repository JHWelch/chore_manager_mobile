import 'package:chore_manager_mobile/components/action_buttons/complete_chore_action.dart';
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
    mockChoreIndex(chores: [chore]);
    Get.put(ChoresController());
  });

  testWidgets('shows icon', (tester) async {
    await tester.pumpWidget(WidgetWrapper(CompleteChoreAction(choreId: 1)));

    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
  });
}
