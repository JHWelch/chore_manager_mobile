import 'package:chore_manager_mobile/components/action_buttons/complete_chore_action.dart';
import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:chore_manager_mobile/pages/show_chore_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import '../factories/chore_factory.dart';
import '../helpers/helpers.dart';
import '../mocks/data_mocks/chore_mocks.dart';
import '../mocks/mocks.dart';

void main() {
  setUp(() async {
    await givenLoggedIn();
  });

  group('show chore route', () {
    late Chore chore;

    setUp(() {
      chore = ChoreFactory().build();
      mockChoreIndex(chores: [chore]);
    });

    testWidgets('can navigate with chore id parameter', (tester) async {
      Get.put(ChoresController());
      await tester.pumpWidget(NavigationTester('/chores/${chore.id}'));
      await tester.pumpAndSettle();

      expect(find.byType(ShowChorePage), findsOneWidget);
      expect(find.text(chore.title), findsOneWidget);
    });

    testWidgets('can navigate with chore object', (tester) async {
      Get.put(ChoresController());
      await tester.pumpWidget(NavigationTester(
        Routes.choreShow,
        arguments: {'chore': chore},
      ));
      await tester.pumpAndSettle();

      expect(find.byType(ShowChorePage), findsOneWidget);
      expect(find.text(chore.title), findsOneWidget);
    });
  });

  testWidgets('shows all chore details', (tester) async {
    final chore = ChoreFactory().build();
    await tester.pumpWidget(WidgetWrapper(ShowChorePage(chore)));

    expect(find.text(chore.title), findsOneWidget);
    expect(find.text(chore.description ?? ''), findsOneWidget);
    expect(find.text(chore.friendlyDueDate), findsOneWidget);
  });

  group('complete chore action', () {
    late Chore chore;

    setUp(() {
      chore = ChoreFactory().build();
      mockChoreIndex(chores: [chore]);
    });

    testWidgets('can complete chore', (tester) async {
      Get.put(ChoresController());
      await tester.pumpWidget(NavigationTester('/chores/${chore.id}'));
      await tester.pumpAndSettle();

      mockChoreComplete(chore: chore);
      mockChoreIndex(chores: [chore]);
      await tester.tap(find.byType(CompleteChoreAction));
      await tester.pumpAndSettle();

      expect(find.byType(ShowChorePage), findsNothing);
    });
  });
}
