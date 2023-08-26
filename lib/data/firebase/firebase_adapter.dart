import 'dart:developer';

import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/device_tokens/device_tokens_adapter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> syncFirebaseToken() async {
  if (!await userAllowsNotifications()) return;

  final tokenAdapter = DeviceTokensAdapter();

  final fcmToken = await Globals.firebase.getToken();
  if (fcmToken != null) {
    await tokenAdapter.store(token: fcmToken);
  }

  Globals.firebase.onTokenRefresh.listen((fcmToken) {
    tokenAdapter.store(token: fcmToken);
  }).onError((err) {
    log(err.toString());
  });
}

Future<bool> userAllowsNotifications() async {
  final settings = await Globals.firebase.requestPermission();

  return _authorizedStatuses.contains(settings.authorizationStatus);
}

const _authorizedStatuses = [
  AuthorizationStatus.authorized,
  AuthorizationStatus.provisional,
];
