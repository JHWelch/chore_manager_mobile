import 'package:chore_manager_mobile/data/chore_manager_web/common/api_response.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/network_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_request.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_response.dart';

class LoginAdapter {
  NetworkAdapter adapter = NetworkAdapter();

  Future<ApiResponse> logIn(LoginRequest loginRequest) async {
    final response = await adapter.post(
        uri: 'token',
        headers: adapter.unauthedHeaders,
        processSuccess: LoginResponse.fromHttpResponse,
        body: <String, String>{
          'email': loginRequest.email,
          'password': loginRequest.password,
          'device_name': 'Flutter App',
        });

    return response;
  }
}
