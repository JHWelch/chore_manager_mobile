import 'package:chore_manager_mobile/data/chore_manager_web/common/network_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/users/auth_user_response.dart';
import 'package:chore_manager_mobile/modules/login/auth_user.dart';

class UsersAdapter {
  NetworkAdapter adapter = NetworkAdapter();

  Future<AuthUser> authUser() async {
    final response = await adapter.get(
      uri: 'auth_user',
      processSuccess: AuthUserResponse.fromHttpResponse,
    );

    if (response.isFailure) throw Exception(response.toString());

    return (response as AuthUserResponse).user;
  }
}
