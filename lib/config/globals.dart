import 'package:chore_manager_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

late http.Client client;
late FirebaseMessaging firebase;
late FlutterSecureStorage storage;

void initHttp() {
  client = IOClient();
}

void initSecureStorage() {
  storage = const FlutterSecureStorage();
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebase = FirebaseMessaging.instance;
}

Future<void> initGlobals() async {
  initHttp();
  initSecureStorage();
  await initFirebase();
}
