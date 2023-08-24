import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/device_tokens/device_tokens_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_response.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/users/users_adapter.dart';
import 'package:chore_manager_mobile/data/secure_storage/secure_storage.dart';
import 'package:chore_manager_mobile/modules/login/auth_user.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static const String tokenKey = 'CM_AUTH_TOKEN';
  final RxString authToken = ''.obs;
  final Rx<AuthUser?> user = Rx<AuthUser?>(null);

  bool get isLoggedIn => authToken().isNotEmpty;

  Future<AuthService> init() async {
    authToken(await retrieveAuthToken() ?? '');

    try {
      if (authToken.isNotEmpty) {
        await fetchAuthUser();
        await postLogin();
      }
    } on Exception {
      authToken('');
    }

    return this;
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    ever<String>(authToken, handleAuthChanged);
  }

  Future<void> finishLogin(LoginResponse loginResponse) async {
    authToken(loginResponse.authToken);
    user(loginResponse.user);
    await storeAuthToken(loginResponse.authToken);
    await postLogin();
  }

  Future<void> postLogin() async {
    await syncFirebaseToken();
  }

  Future<void> syncFirebaseToken() async {
    final fcmToken = await Globals.firebase.getToken();
    if (fcmToken != null) {
      await DeviceTokensAdapter().store(token: fcmToken);
    }
  }

  void handleAuthChanged(String newToken) => newToken.isNotEmpty
      ? Get.offAllNamed(Routes.home)
      : Get.offAllNamed(Routes.login);

  Future<void> fetchAuthUser() async =>
      user(await UsersAdapter(token: authToken()).authUser());
}
