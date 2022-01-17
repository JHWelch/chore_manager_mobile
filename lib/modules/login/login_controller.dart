import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:chore_manager_mobile/modules/login/rx_login_form.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxLoginForm loginForm = RxLoginForm();
  AuthController auth = Get.put(AuthController());

  void logIn() {
    auth.logIn(loginForm.toRequest);
  }
}
