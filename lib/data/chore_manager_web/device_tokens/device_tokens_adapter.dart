import 'package:chore_manager_mobile/data/chore_manager_web/common/api_response.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/network_adapter.dart';

class DeviceTokensAdapter {
  final NetworkAdapter adapter = NetworkAdapter();

  Future<void> store({required String token}) async {
    await adapter.post(
      uri: 'device_tokens',
      body: {'token': token},
      processSuccess: ApiResponse.fromHttpResponse,
    );
  }
}
