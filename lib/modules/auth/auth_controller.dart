import 'package:get/get.dart';

class AuthController extends GetxController {
  static const String tokenKey = 'CM_AUTH_TOKEN';
  final RxString authToken = ''.obs;

  bool get isLoggedIn => authToken().isNotEmpty;
}
