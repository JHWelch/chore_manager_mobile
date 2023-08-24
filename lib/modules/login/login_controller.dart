import 'dart:async';

import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_response.dart';
import 'package:chore_manager_mobile/modules/login/rx_login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxLoginForm loginForm = RxLoginForm();
  AuthService auth = Get.find();
  final LoginAdapter adapter = LoginAdapter();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> logIn() async {
    loginForm.resetErrors();

    if (!_validate()) return;

    final response = await adapter.logIn(loginForm.toRequest);

    if (response.isSuccess && response is LoginResponse) {
      await auth.finishLogin(response);
    } else if (response is ApiErrors) {
      if (response.isServerError) {
        Get.snackbar(
          'Server Error',
          'Something went wrong on our end. Please try again later.',
          snackPosition: SnackPosition.TOP,
        );
      }

      loginForm.errors(response);
    }

    _validate();
  }

  bool _validate() => formKey.currentState!.validate();
}
