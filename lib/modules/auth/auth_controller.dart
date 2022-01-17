import 'package:chore_manager_mobile/data/chore_manager_web/login_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login_request.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static const String tokenKey = 'CM_AUTH_TOKEN';
  final authToken = ''.obs;
  final LoginAdapter adapter = LoginAdapter();

  void logIn(LoginRequest loginRequest) {
    adapter.logIn(loginRequest);
  }
}
