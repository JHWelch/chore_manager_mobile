import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:chore_manager_mobile/pages/login_page.dart';
import 'package:chore_manager_mobile/pages/show_chore_page.dart';
import 'package:get/get.dart';

class Pages {
  static final notFound = GetPage(
    name: Routes.notFound,
    page: LoginPage.new,
  );

  static final routes = [
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
        page: () {
          final choreId = int.parse(Get.parameters['id'] ?? '0');

          final ChoresController choreController = Get.find();

          return ShowChorePage.new(choreController.chore(choreId));
        })
  ];
}
