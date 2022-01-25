import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  final String? token;

  InitialBinding({this.token});

  @override
  void dependencies() {
    Get.put(AuthController(initialToken: token), permanent: true);
  }
}
