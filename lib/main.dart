import 'package:chore_manager_mobile/chore_manager.dart';
import 'package:chore_manager_mobile/config/globals.dart';
import 'package:flutter/material.dart';

void main() {
  Globals.initializeHttp();
  Globals.initializeSecureStorage();

  runApp(const ChoreManager());
}
