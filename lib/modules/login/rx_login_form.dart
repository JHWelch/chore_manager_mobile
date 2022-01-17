import 'package:chore_manager_mobile/data/chore_manager_web/login_request.dart';
import 'package:get/get.dart';

class RxLoginForm {
  RxString email = ''.obs;
  RxString password = ''.obs;

  LoginRequest get toRequest => LoginRequest(
        email: email(),
        password: password(),
      );
}
