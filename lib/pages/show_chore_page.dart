import 'package:chore_manager_mobile/components/cm_scaffold.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:flutter/material.dart';

class ShowChorePage extends StatelessWidget {
  final Chore chore;

  const ShowChorePage(this.chore, {super.key});

  @override
  Widget build(BuildContext context) {
    return CMScaffold(
        title: chore.title,
        body: Column(children: [
          Text(chore.friendlyDueDate),
          Text(chore.friendlyFrequency),
          Text(chore.description ?? ''),
        ]));
  }
}
