import 'package:chore_manager_mobile/modules/login/components/email_field.dart';
import 'package:chore_manager_mobile/modules/login/components/password_field.dart';
import 'package:chore_manager_mobile/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _Title(),
                EmailField(),
                PasswordField(),
                _LoginButton(logIn: controller.logIn),
              ],
            ),
          ),
        ),
      ),
    );
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text(
      'Log in to ChoreManager',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
    );
}

class _LoginButton extends StatelessWidget {
  final void Function() logIn;

  const _LoginButton({required this.logIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: logIn,
      child: const Text('Log In'),
    );
}
