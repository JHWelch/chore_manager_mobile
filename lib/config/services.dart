import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:get/get.dart';

Future<void> initServices() async {
  await Get.putAsync(AuthService().init);
}
