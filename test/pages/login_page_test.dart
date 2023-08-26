import 'dart:convert';

import 'package:chore_manager_mobile/chore_manager.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_error.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';
import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:chore_manager_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../helpers/widget_wrapper.dart';
import '../mocks/data_mocks/chore_mocks.dart';
import '../mocks/data_mocks/device_token_mocks.dart';
import '../mocks/firebase_mocks.dart';
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
  }) =>
      jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'device_name': 'Flutter App'
      });

  Future<void> _tapLogin(WidgetTester tester) async {
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
  }

  group('Unauthenticated users', () {
    testWidgets('can see login page.', (tester) async {
      await tester.pumpWidget(ChoreManager());
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
          path: 'token',
          body: _authJson(),
          response: http.Response(json, 200),
          headers: expectedAuthHeaders(),
        );
        mockFirebaseOnTokenRefreshNoRun();
        mockFirebaseRequestPermission();
      });

      testWidgets('makes login request', (tester) async {
        mockFirebaseGetToken(null);
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);

        verify(() => Globals.client.post(
              expectedPath('token'),
              headers: expectedAuthHeaders(),
              body: _authJson(),
            ));
      });

      testWidgets('user is logged in', (tester) async {
        mockFirebaseGetToken(null);
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);

        final AuthService auth = Get.find();
        expect(auth.isLoggedIn, true);
      });

      testWidgets('user redirected to home screen', (tester) async {
        mockFirebaseGetToken(null);
        mockChoreIndex();

        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);
        await tester.pumpAndSettle();

        expect(find.byType(HomePage), findsOneWidget);
      });

      testWidgets('sync firebase device token with backend', (tester) async {
        mockChoreIndex();
        mockFirebaseGetToken('firebase_token');
        mockDeviceTokenStore(token: 'firebase_token');
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);
        await tester.pumpAndSettle();

        verifyDeviceTokenStore(token: 'firebase_token');
      });
    });

    group('email has api errors', () {
      setUp(() {
        mockPost(
          path: 'token',
          body: _authJson(),
          response: http.Response(
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
          headers: expectedAuthHeaders(),
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

        final AuthService auth = Get.find();
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
          path: 'token',
          headers: expectedAuthHeaders(),
          body: _authJson(password: ''),
          response: http.Response(
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

        final AuthService auth = Get.find();
        expect(auth.isLoggedIn, false);
      });

      testWidgets('user shown error', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester, password: '');
        await _tapLogin(tester);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('The password field is required.'), findsOneWidget);
        expect(find.byType(HomePage), findsNothing);
      });
    });

    group('Server throws generic error', () {
      setUp(() {
        mockFirebaseGetToken(null);
        mockPost(
          path: 'token',
          headers: expectedAuthHeaders(),
          body: _authJson(),
          response: http.Response(jsonEncode({'message': 'Server Error'}), 500),
        );
      });

      testWidgets('user not logged in', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);
        await tester.pump(const Duration(seconds: 4));

        final AuthService auth = Get.find();
        expect(auth.isLoggedIn, false);
      });

      testWidgets('user shown generic error', (tester) async {
        await tester.pumpWidget(WidgetWrapper(LoginPage()));
        await tester.pumpAndSettle();

        await _fillFields(tester);
        await _tapLogin(tester);
        await tester.pump(const Duration(seconds: 2));

        expect(find.text('Server Error'), findsOneWidget);
        expect(
          find.text('Something went wrong on our end. Please try again later.'),
          findsOneWidget,
        );
        expect(find.byType(HomePage), findsNothing);
        await tester.pump(const Duration(seconds: 2));
      });
    });
  });
}
