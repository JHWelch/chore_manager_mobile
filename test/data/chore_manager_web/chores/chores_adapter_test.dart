import 'dart:convert';

import 'package:chore_manager_mobile/config/globals.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/chores/chores_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../factories/chore_factory.dart';
import '../../../mocks/data_mocks/chore_mocks.dart';
import '../../../mocks/http_mocks.dart';
import '../../../mocks/mocks.dart';

void main() {
  setUp(givenLoggedIn);
  group('index', () {
    test('can return chores', () async {
      final chore = ChoreFactory().build();
      mockChoreIndex(chores: [chore]);
      final adapter = ChoresAdapter();

      final chores = await adapter.index();

      expect(chores.first, chore);
    });
  });

  group('complete', () {
    test('can complete chore', () async {
      final chore = ChoreFactory().build();
      mockChoreComplete(chore: chore);
      final adapter = ChoresAdapter();

      await adapter.complete(chore);

      verifyChoreComplete(chore);
    });
  });
}
