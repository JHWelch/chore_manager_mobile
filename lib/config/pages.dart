import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/pages/home_page.dart';
import 'package:chore_manager_mobile/pages/login_page.dart';
import 'package:get/get.dart';

class Pages {
  static final notFound = GetPage(
    name: Routes.notFound,
    page: () => LoginPage(),
  );

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
    ),
  ];
}
