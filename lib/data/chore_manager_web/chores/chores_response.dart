import 'dart:convert';

import 'package:chore_manager_mobile/data/chore_manager_web/common/api_response.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:http/http.dart' as http;

class ChoreIndexResponse extends ApiResponse {
  late final List<Chore> chores;

  ChoreIndexResponse.fromHttpResponse(http.Response response)
      : super.fromHttpResponse(response) {
    chores = (jsonDecode(response.body)['data'] as List)
        .map(Chore.fromJson)
        .toList();
  }
}
