import 'dart:developer';

import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/device_tokens/device_tokens_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_response.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/users/users_adapter.dart';
import 'package:chore_manager_mobile/data/secure_storage/secure_storage.dart';
import 'package:chore_manager_mobile/modules/login/auth_user.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final RxString authToken = ''.obs;
  final Rx<AuthUser?> user = Rx<AuthUser?>(null);

  bool get isLoggedIn => authToken().isNotEmpty;

  Future<AuthService> init() async {
    authToken(await retrieveAuthToken() ?? '');

    return this;
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    ever<String>(authToken, _handleAuthChanged);

    if (authToken.isEmpty || !await _fetchAuthUser()) return;

    await _postLogin();
  }

  Future<void> finishLogin(LoginResponse loginResponse) async {
    authToken(loginResponse.authToken);
    user(loginResponse.user);
    await storeAuthToken(loginResponse.authToken);
    await _postLogin();
  }

  Future<void> logout() async {
    authToken('');
    user.value = null;
    await deleteAuthToken();
  }

  Future<void> _postLogin() => _syncFirebaseToken();

  Future<void> _syncFirebaseToken() async {
    final fcmToken = await Globals.firebase.getToken();
    if (fcmToken != null) {
      await DeviceTokensAdapter().store(token: fcmToken);
    }

    Globals.firebase.onTokenRefresh.listen((fcmToken) {
      DeviceTokensAdapter().store(token: fcmToken);
    }).onError((err) {
      log(err.toString());
    });
  }

  void _handleAuthChanged(String newToken) => newToken.isNotEmpty
      ? Get.offAllNamed(Routes.home)
      : Get.offAllNamed(Routes.login);

  Future<bool> _fetchAuthUser() async {
    try {
      user(await UsersAdapter(token: authToken()).authUser());
      return true;
    } on Exception {
      authToken('');
      return false;
    }
  }
}
