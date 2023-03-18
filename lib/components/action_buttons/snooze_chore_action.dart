import 'package:chore_manager_mobile/constants/strings.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SnoozeChoreAction extends StatelessWidget {
  final int choreId;
  final Function()? postAction;

  final controller = Get.find<ChoresController>();

  SnoozeChoreAction({
    required this.choreId,
    this.postAction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.access_time),
      tooltip: Strings.snooze,
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: _snoozeUntilTomorrow,
          child: const Text(Strings.tomorrowTitle),
        ),
        PopupMenuItem(
          onTap: _snoozeUntilWeekend,
          child: const Text(Strings.weekendTitle),
        ),
      ],
    );
  }

  void _snoozeUntilTomorrow() {
    controller.snoozeUntilTomorrow(choreId);
    postAction?.call();
  }

  void _snoozeUntilWeekend() {
    controller.snoozeUntilWeekend(choreId);
    postAction?.call();
  }
}
