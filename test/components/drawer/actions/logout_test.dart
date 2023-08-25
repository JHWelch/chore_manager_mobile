import 'package:chore_manager_mobile/components/drawer/actions/logout.dart';
import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:chore_manager_mobile/pages/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/secure_storage_mocks.dart';

void main() {
  setUp(() async {
    await givenLoggedIn();
    mockAuthTokenDelete();
  });

  testWidgets('Button displays correctly', (widgetTester) async {
    await widgetTester.pumpWidget(const WidgetWrapper(Logout()));

    expect(find.text('Logout'), findsOneWidget);
  });

  group('press', () {
    testWidgets('user logged out', (widgetTester) async {
      await widgetTester.pumpWidget(const WidgetWrapper(Logout()));

      await widgetTester.tap(find.text('Logout'));

      final auth = Get.find<AuthService>();
      expect(auth.authToken(), '');
      expect(auth.user(), null);
    });

    testWidgets('navigates to login page', (widgetTester) async {
      await widgetTester.pumpWidget(const WidgetWrapper(Logout()));

      await widgetTester.tap(find.text('Logout'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
