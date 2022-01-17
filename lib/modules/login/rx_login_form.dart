import 'package:chore_manager_mobile/data/chore_manager_web/login/login_request.dart';
import 'package:get/get.dart';

class RxLoginForm {
  RxString email = ''.obs;
  RxString password = ''.obs;
  Rx<String?> error = Rx<String?>(null);

  LoginRequest get toRequest => LoginRequest(
        email: email(),
        password: password(),
      );
}
