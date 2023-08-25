import 'package:flutter/material.dart';

class Spinner extends StatefulWidget {
  final IconData icon;
  final Duration duration;

  const Spinner({
    required this.icon,
    this.duration = const Duration(milliseconds: 1800),
    Key? key,
  }) : super(key: key);

  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Widget _child;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    _child = Icon(widget.icon);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RotationTransition(
      turns: _controller,
      child: _child,
    );
}
