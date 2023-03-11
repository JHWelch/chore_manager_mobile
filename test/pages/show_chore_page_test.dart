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
    testWidgets('can navigate with chore id parameter', (tester) async {
      final chore = ChoreFactory().build();
      mockChoreIndex(chores: [chore]);
      Get.put(ChoresController());
      await tester.pumpWidget(NavigationTester('/chores/${chore.id}'));
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
}
