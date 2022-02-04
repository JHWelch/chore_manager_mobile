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
          itemCount: controller.homePageChores().length,
        ),
      ),
    );
  }

  Widget _listItem(BuildContext context, int index) {
    final Chore chore = controller.homePageChores()[index];

    return Dismissible(
      key: ValueKey<int>(chore.id),
      background: _dismissibleBackground,
      secondaryBackground: _dismissibleSecondaryBackground,
      onDismissed: (direction) {},
      child: ListTile(
        title: Text(chore.title),
        trailing: Text(chore.friendlyDueDate),
      ),
    );
  }

  Widget get _dismissibleBackground => Container(
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        color: Colors.purple,
        child: const Icon(Icons.check_circle_outline),
      );

  Widget get _dismissibleSecondaryBackground => Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        color: Colors.purple,
        child: const Icon(Icons.check_circle_outline),
      );
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
