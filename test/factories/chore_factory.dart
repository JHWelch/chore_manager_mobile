import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:faker/faker.dart';

import 'factory.dart';

class ChoreFactory extends Factory<Chore> {
  @override
  Chore build() => Chore(
        id: properties['id'] ?? random.integer(500, min: 1),
        userId: properties['userId'] ?? random.integer(500, min: 1),
        title: properties['title'] ?? faker.lorem.sentence(),
        description: properties['description'] ?? faker.lorem.sentence(),
        createdAt: properties['createdAt'] ?? faker.date.dateTime(),
        updatedAt: properties['updatedAt'] ?? faker.date.dateTime(),
        teamId: properties['teamId'] ?? random.integer(500, min: 1),
        frequencyId: properties['frequencyId'] ?? random.integer(5),
        frequencyInterval: properties['frequencyInterval'] ?? random.integer(5),
        frequencyDayOf: properties['frequencyDayOf'] ?? 0,
        nextDueDate: properties['nextDueDate'] ?? faker.date.dateTime(),
        dueDateUpdatedAt:
            properties['dueDateUpdatedAt'] ?? faker.date.dateTime(),
      );

  ChoreFactory withoutInstance() => state({
        'nextDueDate': null,
        'dueDateUpdatedAt': null,
      }) as ChoreFactory;
}
