import 'package:chore_manager_mobile/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailField extends StatelessWidget {
  final LoginController controller = Get.find();

  EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('email_field'),
      onChanged: controller.loginForm.email,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }
}
