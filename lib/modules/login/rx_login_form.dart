import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_request.dart';
import 'package:get/get.dart';

class RxLoginForm {
  RxString email = ''.obs;
  RxString password = ''.obs;
  Rx<ApiErrors?> errors = Rx<ApiErrors?>(null);

  LoginRequest get toRequest => LoginRequest(
        email: email(),
        password: password(),
      );

  void resetErrors() => errors.value = null;
}
