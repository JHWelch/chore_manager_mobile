import 'package:chore_manager_mobile/data/secure_storage/secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static const String tokenKey = 'CM_AUTH_TOKEN';
  final RxString authToken = ''.obs;

  bool get isLoggedIn => authToken().isNotEmpty;

  Future<void> setup() async {
    authToken(await retrieveAuthToken() ?? '');
  }
}
