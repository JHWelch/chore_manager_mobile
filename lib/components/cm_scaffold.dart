import 'package:flutter/material.dart';

class CMScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;

  const CMScaffold({
    required this.body,
    this.title,
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: title != null ? Text(title!) : null,
        actions: actions,
      ),
      body: body,
    );
}
