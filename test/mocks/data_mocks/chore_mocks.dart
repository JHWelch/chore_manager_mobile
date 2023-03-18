import 'dart:convert';

import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/extensions/date_time_ext.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../http_mocks.dart';

void mockChoreIndex({List<Chore>? chores, Duration? delay}) {
  final Map<String, dynamic> json = {'data': chores ?? []};

  mockGet(
    path: 'chores',
    response: http.Response(jsonEncode(json), 200),
    delay: delay,
  );
}

void mockChoreComplete({required Chore chore}) {
  final Map<String, dynamic> json = {'completed': true};

  mockPatch(
    path: 'chores/${chore.id}',
    body: jsonEncode(json),
    response: http.Response(jsonEncode({'data': chore.toJson()}), 200),
  );
}

void verifyChoreComplete({required Chore chore}) =>
    verify(() => Globals.client.patch(
          expectedPath('chores/${chore.id}'),
          headers: expectedHeaders(),
          body: jsonEncode({'completed': true}),
        ));

void mockChoreSnooze({required Chore chore, required DateTime date}) {
  mockPatch(
    path: 'chores/${chore.id}',
    body: jsonEncode({'next_due_date': date.toDateString()}),
    response: http.Response(jsonEncode({'data': chore.toJson()}), 200),
  );
}

void verifyChoreSnooze({required Chore chore, required DateTime date}) =>
    verify(() => Globals.client.patch(
          expectedPath('chores/${chore.id}'),
          headers: expectedHeaders(),
          body: jsonEncode({'next_due_date': date.toDateString()}),
        ));
