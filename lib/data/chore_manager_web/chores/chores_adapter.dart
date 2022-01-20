import 'dart:convert';

import 'package:chore_manager_mobile/data/common/network_adapter.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';

class ChoresAdapter {
  String? token;
  late final NetworkAdapter adapter;

  ChoresAdapter(this.token) {
    adapter = NetworkAdapter(token: token);
  }

  Future<List<Chore>> index() async {
    final response = await adapter.get(uri: 'chores');

    return (jsonDecode(response.body)['data'] as List)
        .map((e) => Chore.fromJson(e))
        .toList();
  }
}
