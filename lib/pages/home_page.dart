import 'package:chore_manager_mobile/components/cm_scaffold.dart';
import 'package:chore_manager_mobile/components/spinner.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:chore_manager_mobile/modules/chores/chores_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final ChoresController controller = Get.put(ChoresController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CMScaffold(
      title: 'Home',
      actions: [_RefreshButton(controller: controller)],
      body: Obx(
        () => ListView.builder(
          itemBuilder: _listItem,
          itemCount: controller.withDueDate().length,
        ),
      ),
    );
  }

  Widget _listItem(BuildContext context, int index) {
    final Chore chore = controller.withDueDate()[index];
    return ListTile(
      title: Text(chore.title),
      trailing: Text(chore.friendlyDueDate),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final ChoresController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        onPressed: controller.refreshChores,
        icon: controller.isLoading()
            ? const Spinner(icon: Icons.refresh)
            : const Icon(Icons.refresh),
      ),
    );
  }
}
