import 'dart:convert';

import 'package:chore_manager_mobile/chore_manager.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_error.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';
import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:chore_manager_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../helpers/widget_wrapper.dart';
import '../mocks/data_mocks/chore_mocks.dart';
import '../mocks/http_mocks.dart';
import '../mocks/mocks.dart';
import '../mocks/secure_storage_mocks.dart';

void main() {
  setUp(() async {
    await givenNotLoggedIn();
    mockAuthTokenWrite(mockTokenString);
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
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
  }

  group('Unauthenticated users', () {
    testWidgets('can see login page.', (tester) async {
      await tester.pumpWidget(const ChoreManager());
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });

    group('enter correct credentials', () {
      setUp(() {
        final json = jsonEncode({
          'token': mockTokenString,
          'user': {
            'id': 1,
            'name': 'John Smith',
            'email': 'jsmith@example.com',
            'profile_photo_path':
                'https://randomuser.me/api/portraits/men/81.jpg',
            'current_team_id': 1,
          }
        });

        mockPost(
          'token',
          http.Response(json, 200),
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
        mockChoreIndex();

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
            ApiErrors(
              statusCode: 422,
              message: 'The given data was invalid.',
              errors: [
                const ApiError(field: 'email', messages: [
                  'The provided credentials are incorrect.',
                ])
              ],
            ).toJsonString(),
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
            ApiErrors(
              statusCode: 422,
              message: 'The given data was invalid.',
              errors: [
                const ApiError(field: 'password', messages: [
                  'The password field is required.',
                ]),
              ],
            ).toJsonString(),
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
