import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  AuthService get auth => Get.find<AuthService>();

  @override
  Widget build(BuildContext context) => ListTile(
        title: const Text('Logout'),
        onTap: auth.logout,
      );
}
