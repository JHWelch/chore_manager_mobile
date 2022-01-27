import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  final String? token;

  InitialBinding({this.token});

  @override
  void dependencies() {
    Get.put(AuthService(initialToken: token), permanent: true);
  }
}
