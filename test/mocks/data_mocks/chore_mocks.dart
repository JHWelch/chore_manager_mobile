import 'dart:convert';

import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:http/http.dart' as http;

import '../http_mocks.dart';

void mockChoreIndex({List<Chore>? chores}) {
  final Map<String, dynamic> json = {'data': chores ?? []};

  mockGet(path: 'chores', response: http.Response(jsonEncode(json), 200));
}

void mockChoreComplete({required Chore chore}) {
  final Map<String, dynamic> json = {'completed': true};

  mockPatch(
    path: 'chores/${chore.id}',
    body: jsonEncode(json),
    response: http.Response(chore.toJsonString(), 200),
  );
}
