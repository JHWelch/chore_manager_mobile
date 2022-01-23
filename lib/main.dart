import 'package:chore_manager_mobile/chore_manager.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/data/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  Globals.initializeHttp();
  Globals.initializeSecureStorage();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChoreManager(token: await retrieveAuthToken()));
}
