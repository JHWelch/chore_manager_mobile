import 'package:chore_manager_mobile/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordField extends StatelessWidget {
  final LoginController controller = Get.find();

  PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('password_field'),
      onChanged: controller.loginForm.password,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
