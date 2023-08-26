import 'package:chore_manager_mobile/config/globals.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mocktail/mocktail.dart';

void mockFirebaseGetToken(String? token) =>
    when(() => Globals.firebase.getToken()).thenAnswer((_) async => token);

void mockFirebaseOnTokenRefreshNoRun() =>
    when(() => Globals.firebase.onTokenRefresh)
        .thenAnswer((_) => const Stream.empty());

void mockFirebaseRequestPermission({
  AuthorizationStatus status = AuthorizationStatus.authorized,
}) =>
    when(() => Globals.firebase.requestPermission())
        .thenAnswer((_) async => NotificationSettings(
              authorizationStatus: AuthorizationStatus.authorized,
              alert: _notificationStatus(status),
              badge: _notificationStatus(status),
              sound: _notificationStatus(status),
              lockScreen: _notificationStatus(status),
              notificationCenter: _notificationStatus(status),
              showPreviews: AppleShowPreviewSetting.always,
              announcement: AppleNotificationSetting.disabled,
              carPlay: AppleNotificationSetting.disabled,
              criticalAlert: AppleNotificationSetting.disabled,
              timeSensitive: _notificationStatus(status),
            ));

AppleNotificationSetting _notificationStatus(AuthorizationStatus status) => [
      AuthorizationStatus.authorized,
      AuthorizationStatus.provisional,
    ].contains(status)
        ? AppleNotificationSetting.enabled
        : AppleNotificationSetting.disabled;
