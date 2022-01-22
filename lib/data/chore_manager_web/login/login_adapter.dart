import 'package:chore_manager_mobile/data/chore_manager_web/common/network_adapter.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_request.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/login/login_response.dart';
import 'package:http/http.dart' as http;

class LoginAdapter {
  NetworkAdapter adapter = NetworkAdapter();

  Future<LoginResponse> logIn(LoginRequest loginRequest) async {
    final http.Response response = await adapter.post(
        uri: 'token',
        headers: adapter.unauthedHeaders,
        body: <String, String>{
          'email': loginRequest.email,
          'password': loginRequest.password,
          'device_name': 'Flutter App'
        });

    return LoginResponse.fromHttpResponse(response);
  }
}
