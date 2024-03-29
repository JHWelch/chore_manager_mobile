import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:chore_manager_mobile/pages/login_page.dart';
import 'package:chore_manager_mobile/pages/show_chore_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final notFoundPage = GetPage(
  name: Routes.notFound,
  page: LoginPage.new,
);

final routes = [
  GetPage(
    name: Routes.login,
    page: LoginPage.new,
  ),
  GetPage(
    name: Routes.home,
    page: HomePage.new,
  ),
  GetPage(
    name: Routes.choreShow,
    page: choreShowNavigate,
  )
];

Widget choreShowNavigate() {
  final Chore? chore = Get.arguments?['chore'];
  if (chore != null) return ShowChorePage.new(chore);

  final String? choreId = Get.parameters['id'];
  if (choreId == null) throw Exception('No chore found');

  final ChoresController choreController = Get.find();

  return ShowChorePage.new(choreController.chore(int.parse(choreId)));
}
