import 'package:flutter/material.dart';

import '../models/activity.dart';

class EditableActivity extends StatelessWidget {
  final Activity activity;

  const EditableActivity({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      title: Text(
        activity.name,
        style: theme.textTheme.headline4?.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
