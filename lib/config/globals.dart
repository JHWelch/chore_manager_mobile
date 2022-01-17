import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class Globals {
  static late http.Client client;
  static late FlutterSecureStorage storage;

  static void initializeHttp() {
    client = IOClient();
  }

  static void initializeSecureStorage() {
    storage = const FlutterSecureStorage();
  }
}
