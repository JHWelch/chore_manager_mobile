import 'package:chore_manager_mobile/data/firebase/firebase_adapter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/data_mocks/device_token_mocks.dart';
import '../../mocks/firebase_mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  group('syncFirebaseToken', () {
    setUp(givenLoggedIn);

    group('when auth status is not determined', () {
      group('user grants permission', () {
        setUp(() {
          mockFirebaseGetToken('firebase_token');
          mockDeviceTokenStore(token: 'firebase_token');
          mockFirebaseOnTokenRefreshNoRun();
          mockFirebaseRequestPermission();
        });

        test('stores token', () async {
          await syncFirebaseToken();

          verifyDeviceTokenStore(token: 'firebase_token');
        });
      });

      group('user does not grant permission', () {
        setUp(() {
          mockFirebaseRequestPermission(status: AuthorizationStatus.denied);
        });

        test('does not store token', () async {
          await syncFirebaseToken();

          verifyNeverDeviceTokenStore(token: 'firebase_token');
        });
      });
    });

    group('when auth status is denied', () {
      setUp(() {
        mockFirebaseGetNotificationSettings(status: AuthorizationStatus.denied);
      });

      test('does not ask for permission', () async {
        await syncFirebaseToken();

        verifyNeverFirebaseRequestPermission();
      });

      test('does not store token', () async {
        await syncFirebaseToken();

        verifyNeverDeviceTokenStore(token: 'firebase_token');
      });
    });

    group('when auth status is authorized', () {
      setUp(() {
        mockFirebaseGetToken('firebase_token');
        mockDeviceTokenStore(token: 'firebase_token');
        mockFirebaseOnTokenRefreshNoRun();
        mockFirebaseGetNotificationSettings(
          status: AuthorizationStatus.authorized,
        );
      });

      test('does not ask for permission', () async {
        await syncFirebaseToken();

        verifyNeverFirebaseRequestPermission();
      });

      test('stores token', () async {
        await syncFirebaseToken();

        verifyDeviceTokenStore(token: 'firebase_token');
      });
    });

    group('when auth throws error', () {
      setUp(() {
        mockFirebaseGetNotificationSettings();
        mockFirebaseOnTokenRefreshNoRun();
        mockFirebaseRequestPermission();
        mockFirebaseGetTokenFails();
      });

      test('does not ask for permission', () async {
        expect(syncFirebaseToken, returnsNormally);

        verifyNeverFirebaseRequestPermission();
      });

      test('does not store token', () async {
        expect(syncFirebaseToken, returnsNormally);

        verifyNeverDeviceTokenStore(token: 'firebase_token');
      });
    });
  });
}
