import 'package:chore_manager_mobile/components/drawer/actions/logout.dart';
import 'package:chore_manager_mobile/components/drawer/cm_drawer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';
import '../../mocks/mocks.dart';

void main() {
  setUp(givenLoggedIn);

  testWidgets('drawer has correct actions', (widgetTester) async {
    await widgetTester.pumpWidget(const WidgetWrapper(CMDrawer()));
    await widgetTester.pumpAndSettle();

    expect(find.byType(Logout), findsOneWidget);
  });
}
