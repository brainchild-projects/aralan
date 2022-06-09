import 'package:flutter/material.dart';

class H2 extends StatelessWidget {
  final String text;
  const H2(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.headline4,
    );
  }
}
