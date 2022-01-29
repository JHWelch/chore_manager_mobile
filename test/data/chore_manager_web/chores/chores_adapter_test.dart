import 'package:chore_manager_mobile/data/chore_manager_web/chores/chores_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../factories/chore_factory.dart';
import '../../../mocks/data_mocks/chore_mocks.dart';
import '../../../mocks/mocks.dart';

void main() {
  setUp(givenLoggedIn);
  group('index', () {
    testWidgets('can return chores', (tester) async {
      final chore = ChoreFactory().build();
      mockChoreIndex(chores: [chore]);
      final adapter = ChoresAdapter();

      final chores = await adapter.index();

      expect(chores.first, chore);
    });
  });
}
