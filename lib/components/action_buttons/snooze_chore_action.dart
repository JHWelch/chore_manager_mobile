import 'package:chore_manager_mobile/constants/strings.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return IconButton(
      icon: const Icon(Icons.access_time),
      onPressed: _snoozeChore,
      tooltip: Strings.snooze,
    );
  }

  void _snoozeChore() {
    controller.completeChore(choreId);
    postAction?.call();
  }
}
