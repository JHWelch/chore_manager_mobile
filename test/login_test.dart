import 'dart:convert';

import 'package:chore_manager_mobile/chore_manager.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'helpers/widget_wrapper.dart';
import 'mocks/http_mocks.dart';
import 'mocks/mocks.dart';

void main() {
  setUp(() async {
    givenNotLoggedIn();
  });

  tearDown(() async {
    Get.reset();
  });

  /// HELPERS
  Future<void> _fillFields(
    WidgetTester tester, {
    String email = 'jsmith@example.com',
    String password = 'pw123456',
  }) async {
    final emailField = find.byKey(const Key('email_field'));
    final passwordField = find.byKey(const Key('password_field'));
    await tester.enterText(emailField, email);
    await tester.enterText(passwordField, password);
  }

  String _authJson({
    String email = 'jsmith@example.com',
    String password = 'pw123456',
  }) {
    return jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'device_name': 'Flutter App'
    });
  }

  Future<void> _tapLogin(WidgetTester tester) async {
    await tester.tap(find.widgetWithText(TextButton, 'Log In'));
  }

  group('Unauthenticated users', () {
    testWidgets('can see login page.', (tester) async {
      await tester.pumpWidget(const ChoreManager());
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });

    group('enter correct credentials', () {
      testWidgets('can log in.', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);

        mockPost(
          'token',
          http.Response(mockTokenString, 200),
          _authJson(),
          expectedAuthHeaders(),
        );

        await _tapLogin(tester);

        verify(
          () => Globals.client.post(
            expectedPath('token'),
            headers: expectedAuthHeaders(),
            body: _authJson(),
          ),
        );
      });
    });
  });
}
