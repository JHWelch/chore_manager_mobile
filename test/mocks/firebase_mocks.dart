import 'package:chore_manager_mobile/config/globals.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mocktail/mocktail.dart';

void mockFirebaseGetToken(String? token) =>
    when(() => firebase.getToken()).thenAnswer((_) async => token);

void mockFirebaseOnTokenRefreshNoRun() =>
    when(() => firebase.onTokenRefresh).thenAnswer((_) => const Stream.empty());

void mockFirebaseRequestPermission({
  AuthorizationStatus status = AuthorizationStatus.provisional,
}) {
  mockFirebaseGetNotificationSettings();
  when(() => firebase.requestPermission(provisional: true))
      .thenAnswer((_) async => _notificationSettingsMock(status));
}

void mockFirebaseGetNotificationSettings({
  AuthorizationStatus status = AuthorizationStatus.notDetermined,
}) =>
    when(() => firebase.getNotificationSettings())
        .thenAnswer((_) async => _notificationSettingsMock(status));

void verifyNeverFirebaseRequestPermission() =>
    verifyNever(() => firebase.requestPermission(provisional: true));

NotificationSettings _notificationSettingsMock(AuthorizationStatus status) =>
    NotificationSettings(
      authorizationStatus: status,
      alert: _notificationStatus(status),
      badge: _notificationStatus(status),
      sound: _notificationStatus(status),
      lockScreen: _notificationStatus(status),
      notificationCenter: _notificationStatus(status),
      showPreviews: AppleShowPreviewSetting.always,
      announcement: AppleNotificationSetting.notSupported,
      carPlay: AppleNotificationSetting.disabled,
      criticalAlert: AppleNotificationSetting.disabled,
      timeSensitive: _notificationStatus(status),
    );

AppleNotificationSetting _notificationStatus(AuthorizationStatus status) => [
      AuthorizationStatus.authorized,
      AuthorizationStatus.provisional,
    ].contains(status)
        ? AppleNotificationSetting.enabled
        : AppleNotificationSetting.disabled;
