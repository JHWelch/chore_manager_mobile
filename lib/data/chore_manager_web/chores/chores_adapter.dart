import 'dart:convert';

import 'package:chore_manager_mobile/config/routes.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/network_adapter.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class ChoresAdapter {
  String? token;
  late final NetworkAdapter adapter;

  ChoresAdapter(this.token) {
    adapter = NetworkAdapter(token: token);
  }

  Future<List<Chore>> index() async {
    final response = await adapter.get(uri: 'chores');

    if (response.statusCode != HttpStatus.ok) {
      final errors = ApiErrors.fromHttpResponse(response);

      if (errors.isAuthError()) {
        await Get.offAllNamed(Routes.login);
        return [];
      }
    }

    return (jsonDecode(response.body)['data'] as List)
        .map((e) => Chore.fromJson(e))
        .toList();
  }
}
