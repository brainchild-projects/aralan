import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const NavigationButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Positioned(
      top: 20,
      left: 20,
      child: IconButton(
        color: theme.colorScheme.onBackground,
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}
