import 'package:chore_manager_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

late http.Client client;
late FirebaseMessaging firebase;
late FlutterSecureStorage storage;

Future<void> initGlobals() async {
  _initHttp();
  _initSecureStorage();
  await _initFirebase();
}

void _initHttp() {
  client = IOClient();
}

void _initSecureStorage() {
  storage = const FlutterSecureStorage();
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _initFirebaseCrashlytics();
  _initFirebaseMessaging();
}

void _initFirebaseCrashlytics() {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

void _initFirebaseMessaging() {
  firebase = FirebaseMessaging.instance;
}
