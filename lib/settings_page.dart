import 'package:aralan/elements/navigation_button.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            NavigationButton(
              icon: Icons.arrow_back,
              onPressed: () => {Navigator.pop(context)},
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Settings',
                    style: theme.textTheme.headline3,
                  ),
                  Text(
                    'All Tasks',
                    style: theme.textTheme.headline4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
