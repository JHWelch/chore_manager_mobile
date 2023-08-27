import 'package:chore_manager_mobile/config/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetWrapper extends StatelessWidget {
  final Widget widget;

  const WidgetWrapper(this.widget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        home: Scaffold(body: widget),
        getPages: routes,
      );
}
