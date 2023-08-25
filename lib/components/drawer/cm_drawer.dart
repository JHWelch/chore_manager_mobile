import 'package:chore_manager_mobile/components/drawer/actions/logout.dart';
import 'package:flutter/material.dart';

class CMDrawer extends StatelessWidget {
  const CMDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: const [
            // DrawerHeader(),
            Logout(),
          ],
        ),
      );
}
