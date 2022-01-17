import 'package:chore_manager_mobile/data/chore_manager_web/login_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login_request.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login_response.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static const String tokenKey = 'CM_AUTH_TOKEN';
  final LoginAdapter adapter = LoginAdapter();
  final RxString authToken = ''.obs;

  bool get isLoggedIn => authToken().isNotEmpty;

  Future<void> logIn(LoginRequest loginRequest) async {
    final LoginResponse response = await adapter.logIn(loginRequest);

    if (response.isSuccess) {
      authToken(response.authToken);
    }
  }
}
