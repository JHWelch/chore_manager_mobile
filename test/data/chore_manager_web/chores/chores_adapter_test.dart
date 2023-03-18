import 'package:chore_manager_mobile/data/chore_manager_web/chores/chores_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../factories/chore_factory.dart';
import '../../../mocks/data_mocks/chore_mocks.dart';
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

      verifyChoreComplete(chore: chore);
    });
  });

  group('snooze', () {
    test('can snooze chore', () async {
      final chore = ChoreFactory().build();
      final date = DateTime.now().add(const Duration(days: 1));
      mockChoreSnooze(chore: chore, date: date);
      final adapter = ChoresAdapter();

      await adapter.snooze(chore, date);

      verifyChoreSnooze(chore: chore, date: date);
    });
  });
}
