import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool positioned;

  const NavigationButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.positioned = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final button = IconButton(
      color: theme.colorScheme.onBackground,
      icon: Icon(icon),
      onPressed: onPressed,
    );
    if (positioned) {
      return Positioned(
        top: 20,
        left: 20,
        child: button,
      );
    }
    return button;
  }
}
