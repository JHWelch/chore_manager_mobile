import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_response.dart';
import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:chore_manager_mobile/modules/login/rx_login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxLoginForm loginForm = RxLoginForm();
  AuthController auth = Get.put(AuthController());
  final LoginAdapter adapter = LoginAdapter();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> logIn() async {
    loginForm.error(null);
    if (_isValid) {
      final LoginResponse response = await adapter.logIn(loginForm.toRequest);

      if (response.isSuccess) {
        auth.authToken(response.authToken);
        await Get.toNamed(Routes.home);
      } else {
        loginForm.error(response.firstError);
      }
    }
  }

  bool get _isValid => formKey.currentState!.validate();
}
