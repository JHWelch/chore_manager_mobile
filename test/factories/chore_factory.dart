import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:faker/faker.dart';

import 'factory.dart';

class ChoreFactory extends Factory<Chore> {
  @override
  Chore build() => Chore(
        id: getProperty('id', random.integer(500, min: 1)),
        userId: getProperty('userId', random.integer(500, min: 1)),
        title: getProperty('title', faker.lorem.sentence()),
        description: getProperty('description', faker.lorem.sentence()),
        createdAt: getProperty('createdAt', faker.date.dateTime()),
        updatedAt: getProperty('updatedAt', faker.date.dateTime()),
        teamId: getProperty('teamId', random.integer(500, min: 1)),
        frequencyId: getProperty('frequencyId', random.integer(5)),
        frequencyInterval: getProperty('frequencyInterval', random.integer(5)),
        frequencyDayOf: getProperty('frequencyDayOf', 0),
        nextDueUserId: getProperty('nextDueUserId', 1),
        nextDueDate: getProperty('nextDueDate', date()),
        dueDateUpdatedAt:
            getProperty('dueDateUpdatedAt', faker.date.dateTime()),
      );

  ChoreFactory withoutInstance() => state({
        'nextDueDate': null,
        'dueDateUpdatedAt': null,
      }) as ChoreFactory;
}
