import 'dart:convert';

import 'package:chore_manager_mobile/data/chore_manager_web/common/api_response.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:http/http.dart' as http;

class ChoreResponse extends ApiResponse {
  late final Chore chore;

  ChoreResponse.fromHttpResponse(http.Response response)
      : super.fromHttpResponse(response) {
    chore = Chore.fromJson(jsonDecode(response.body)['data']);
  }
}
