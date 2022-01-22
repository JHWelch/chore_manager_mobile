import 'dart:convert';

import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:http/http.dart' as http;

import '../http_mocks.dart';

void mockChoreIndex({List<Chore>? chores}) {
  final Map<String, dynamic> json = {'data': chores ?? []};

  mockGet('chores', http.Response(jsonEncode(json), 200));
}
