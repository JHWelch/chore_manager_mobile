import 'dart:convert';

import 'package:chore_manager_mobile/chore_manager.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:chore_manager_mobile/pages/home_page.dart';
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
    Get.testMode = true;
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
      setUp(() {
        mockPost(
          'token',
          http.Response(mockTokenString, 200),
          _authJson(),
          expectedAuthHeaders(),
        );
      });

      testWidgets('makes login request', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);

        verify(
          () => Globals.client.post(
            expectedPath('token'),
            headers: expectedAuthHeaders(),
            body: _authJson(),
          ),
        );
      });

      testWidgets('user is logged in', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);

        final AuthController auth = Get.find();
        expect(auth.isLoggedIn, true);
      });

      testWidgets('user redirected to home screen', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);
        await tester.pumpAndSettle();

        expect(find.byType(HomePage), findsOneWidget);
      });
    });

    group('email has api errors', () {
      setUp(() {
        mockPost(
          'token',
          http.Response(
            '''
            {
              "message": "The given data was invalid.",
              "errors": {
                "email": [
                  "The provided credentials are incorrect."
                ]
              }
            }
          ''',
            422,
          ),
          _authJson(),
          expectedAuthHeaders(),
        );
      });

      testWidgets('makes login request', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);

        verify(
          () => Globals.client.post(
            expectedPath('token'),
            headers: expectedAuthHeaders(),
            body: _authJson(),
          ),
        );
      });

      testWidgets('user not logged in', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);

        final AuthController auth = Get.find();
        expect(auth.isLoggedIn, false);
      });

      testWidgets('user shown error', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          find.text('The provided credentials are incorrect.'),
          findsOneWidget,
        );
        expect(find.byType(HomePage), findsNothing);
      });
    });

    group('password has api errors', () {
      setUp(() {
        mockPost(
          'token',
          http.Response(
            '''
            {
              "message": "The given data was invalid.",
              "errors": {
                "password": [
                  "The password field is required."
                ]
              }
            }
          ''',
            422,
          ),
          _authJson(password: ''),
          expectedAuthHeaders(),
        );
      });

      testWidgets('makes login request', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester, password: '');
        await _tapLogin(tester);

        verify(
          () => Globals.client.post(
            expectedPath('token'),
            headers: expectedAuthHeaders(),
            body: _authJson(password: ''),
          ),
        );
      });

      testWidgets('user not logged in', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester, password: '');
        await _tapLogin(tester);

        final AuthController auth = Get.find();
        expect(auth.isLoggedIn, false);
      });

      testWidgets('user shown error', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester, password: '');
        await _tapLogin(tester);
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          find.text('The password field is required.'),
          findsOneWidget,
        );
        expect(find.byType(HomePage), findsNothing);
      });
    });
  });
}
