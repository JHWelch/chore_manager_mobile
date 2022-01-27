import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class Globals {
  static late http.Client client;
  static late FlutterSecureStorage storage;

  static void initHttp() {
    client = IOClient();
  }

  static void initSecureStorage() {
    storage = const FlutterSecureStorage();
  }
}
