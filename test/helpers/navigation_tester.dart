import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'helpers.dart';

class NavigationTester extends StatelessWidget {
  final String route;
  final Duration delay;
  final dynamic arguments;
  final Map<String, String>? parameters;

  const NavigationTester(
    this.route, {
    this.delay = Duration.zero,
    this.arguments,
    this.parameters,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      delay,
      () => Get.toNamed(
        route,
        arguments: arguments,
        parameters: parameters,
      ),
    );

    return const WidgetWrapper(SizedBox.shrink());
  }
}
