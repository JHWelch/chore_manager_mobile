import 'package:chore_manager_mobile/data/chore_manager_web/chores/chores_response.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/api_errors.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/common/network_adapter.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoresAdapter {
  final NetworkAdapter adapter = NetworkAdapter();

  Future<List<Chore>> index() async {
    var response = await adapter.get(
      uri: 'chores',
      processSuccess: ChoreIndexResponse.fromHttpResponse,
    );

    if (response.isFailure) {
      response = response as ApiErrors;

      await Get.dialog(Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Text(response.message),
        ),
      ));
    }

    response = response as ChoreIndexResponse;
    return response.chores;
  }
}
