import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/data/secure_storage/secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static const String tokenKey = 'CM_AUTH_TOKEN';
  final RxString authToken = ''.obs;

  AuthController({String? initialToken}) {
    authToken(initialToken ?? '');
  }

  bool get isLoggedIn => authToken().isNotEmpty;

  @override
  Future<void> onInit() async {
    super.onInit();

    ever<String>(authToken, handleAuthChanged);
  }

  Future<void> finishLogin(String? token) async {
    authToken(token);
    await storeAuthToken(token);
  }

  void handleAuthChanged(String newToken) {
    if (newToken.isNotEmpty) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
