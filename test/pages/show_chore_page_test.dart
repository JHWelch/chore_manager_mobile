import 'package:chore_manager_mobile/pages/show_chore_page.dart';
import 'package:flutter_test/flutter_test.dart';
import '../factories/chore_factory.dart';
import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {
  setUp(() async {
    await givenLoggedIn();
  });

  testWidgets('shows all chore details', (tester) async {
    final chore = ChoreFactory().build();
    await tester.pumpWidget(WidgetWrapper(ShowChorePage(chore)));

    expect(find.text(chore.title), findsOneWidget);
    expect(find.text(chore.description ?? ''), findsOneWidget);
    expect(find.text(chore.friendlyDueDate), findsOneWidget);
  });
}
