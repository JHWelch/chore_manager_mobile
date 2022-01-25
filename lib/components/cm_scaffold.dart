import 'package:flutter/material.dart';

class CMScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;

  const CMScaffold({
    required this.body,
    required this.title,
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: body,
    );
  }
}
