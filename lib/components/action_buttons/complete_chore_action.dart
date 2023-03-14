import 'package:chore_manager_mobile/constants/strings.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteChoreAction extends StatelessWidget {
  final int choreId;

  final controller = Get.find<ChoresController>();

  CompleteChoreAction({
    required this.choreId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.check_circle_outline),
      onPressed: () => controller.completeChore(choreId),
      tooltip: Strings.complete,
    );
  }
}
