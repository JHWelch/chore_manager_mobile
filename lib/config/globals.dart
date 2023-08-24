import 'package:chore_manager_mobile/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class Globals {
  static late http.Client client;
  static late FirebaseMessaging firebase;
  static late FlutterSecureStorage storage;

  static void initHttp() {
    client = IOClient();
  }

  static void initSecureStorage() {
    storage = const FlutterSecureStorage();
  }

  static Future<void> initFirebase() async {
    firebase = FirebaseMessaging.instance;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> init() async {
    initHttp();
    initSecureStorage();
    await initFirebase();
  }
}
