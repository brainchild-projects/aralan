import 'package:flutter/material.dart';

class ColoredScrollableChild extends StatelessWidget {
  final Color color;
  final Widget child;
  const ColoredScrollableChild({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
