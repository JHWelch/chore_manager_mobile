import 'package:chore_manager_mobile/components/action_buttons/complete_chore_action.dart';
import 'package:chore_manager_mobile/components/action_buttons/snooze_chore_action.dart';
import 'package:chore_manager_mobile/components/cm_scaffold.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowChorePage extends StatelessWidget {
  final Chore chore;

  ShowChorePage(this.chore, {super.key});

  final controller = Get.find<ChoresController>();

  @override
  Widget build(BuildContext context) {
    return CMScaffold(
      actions: [
        CompleteChoreAction(choreId: chore.id, postAction: Get.back),
        SnoozeChoreAction(choreId: chore.id, postAction: Get.back),
      ],
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chore.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                chore.friendlyDueDate,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('Repeats ${chore.friendlyFrequency}'),
              Text(chore.description ?? ''),
            ],
          )),
    );
  }
}
