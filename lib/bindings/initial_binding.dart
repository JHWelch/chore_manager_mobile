import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true).setup();
  }
}
