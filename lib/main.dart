import 'package:chore_manager_mobile/chore_manager.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/config/services.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  Globals.initHttp();
  Globals.initSecureStorage();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(ChoreManager());
}
