import 'package:chore_manager_mobile/modules/login/components/email_field.dart';
import 'package:chore_manager_mobile/modules/login/components/password_field.dart';
import 'package:chore_manager_mobile/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Log in to ChoreManager'),
              Obx(
                () => Text(
                  controller.loginForm.error() ?? '',
                  key: const Key('error'),
                ),
              ),
              EmailField(),
              PasswordField(),
              _LoginButton(logIn: controller.logIn),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final void Function() logIn;

  const _LoginButton({required this.logIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: logIn,
      child: const Text('Log In'),
    );
  }
}
