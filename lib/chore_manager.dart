import 'package:chore_manager_mobile/config/pages.dart';
import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/config/themes.dart';
import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoreManager extends GetMaterialApp {
  final AuthService auth = Get.find();

  ChoreManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'ChoreManager',
        theme: Themes.primary,
        getPages: routes,
        initialRoute: initialRoute,
        unknownRoute: notFoundPage,
        debugShowCheckedModeBanner: false,
      );

  @override
  String get initialRoute =>
      auth.authToken().isNotEmpty ? Routes.home : Routes.login;
}
