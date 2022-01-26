import 'package:chore_manager_mobile/data/chore_manager_web/chores/chores_response.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/network_adapter.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';

class ChoresAdapter {
  String? token;
  late final NetworkAdapter adapter;

  ChoresAdapter(this.token) {
    adapter = NetworkAdapter(token: token);
  }

  Future<List<Chore>> index() async {
    var response = await adapter.get(
      uri: 'chores',
      processSuccess: ChoreIndexResponse.fromHttpResponse,
    );
    response = response as ChoreIndexResponse;

    return response.isSuccess ? response.chores : [];
  }
}
