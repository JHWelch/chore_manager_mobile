import 'package:chore_manager_mobile/components/cm_scaffold.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CMScaffold(
      title: 'Home',
      body: Center(
        child: Text('Temp Home'),
      ),
    );
  }
}
