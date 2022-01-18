import 'package:chore_manager_mobile/components/form_widgets/cm_text_input_field.dart';
import 'package:chore_manager_mobile/components/form_widgets/validators/api_validator.dart';
import 'package:chore_manager_mobile/components/form_widgets/validators/validators.dart';
import 'package:chore_manager_mobile/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailField extends StatelessWidget with HasValidation {
  final LoginController controller = Get.find();

  EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CMTextInputField(
      key: const Key('email_field'),
      onChanged: controller.loginForm.email,
      validator: validate,
      labelText: 'Email',
    );
  }

  @override
  List<Validator> get validators => [
        ApiValidator(field: 'email', errors: controller.loginForm.errors),
      ];
}
