import 'package:chore_manager_mobile/components/cm_scaffold.dart';
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
      body: Obx(
        () => ListView.builder(
          itemBuilder: _listItem,
          itemCount: controller.withDueDate().length,
        ),
      ),
    );
  }

  Widget _listItem(BuildContext context, int index) {
    return ListTile(
      title: Text(controller.withDueDate()[index].title),
    );
  }
}
