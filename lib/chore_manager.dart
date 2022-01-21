import 'package:chore_manager_mobile/bindings/initial_binding.dart';
import 'package:chore_manager_mobile/config/pages.dart';
import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/config/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoreManager extends GetMaterialApp {
  const ChoreManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ChoreManager',
      theme: Themes.primary,
      getPages: Pages.routes,
      initialRoute: Routes.initial,
      unknownRoute: Pages.notFound,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
    );
  }
}
