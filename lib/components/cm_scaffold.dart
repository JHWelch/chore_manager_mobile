import 'package:flutter/material.dart';

class CMScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const CMScaffold({
    required this.body,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: body,
    );
  }
}
