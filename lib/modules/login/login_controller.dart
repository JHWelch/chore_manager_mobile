import 'package:chore_manager_mobile/data/chore_manager_web/login/login_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_response.dart';
import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:chore_manager_mobile/modules/login/rx_login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxLoginForm loginForm = RxLoginForm();
  AuthController auth = Get.find();
  final LoginAdapter adapter = LoginAdapter();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> logIn() async {
    loginForm.resetErrors();

    if (_validate()) {
      final LoginResponse response = await adapter.logIn(loginForm.toRequest);

      if (response.isSuccess) {
        await auth.finishLogin(response);
      } else {
        loginForm.errors(response.errors);
      }
    }

    _validate();
  }

  bool _validate() => formKey.currentState!.validate();
}
