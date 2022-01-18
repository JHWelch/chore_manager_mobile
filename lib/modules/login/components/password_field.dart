import 'package:chore_manager_mobile/components/form_widgets/cm_text_input_field.dart';
import 'package:chore_manager_mobile/components/form_widgets/validators/validators.dart';
import 'package:chore_manager_mobile/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordField extends StatelessWidget with HasValidation {
  final LoginController controller = Get.find();

  PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CMTextInputField(
      key: const Key('password_field'),
      onChanged: controller.loginForm.password,
      labelText: 'Password',
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: validate,
    );
  }

  @override
  List<Validator> get validators => [
        ApiValidator(field: 'password', errors: controller.loginForm.errors),
      ];
}
