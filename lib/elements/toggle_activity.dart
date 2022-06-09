import 'package:flutter/material.dart';

import '../models/activity.dart';

typedef OnToggleActivity = Function(bool?);

class ToggleActivity extends StatelessWidget {
  final CheckableActivity activity;
  final OnToggleActivity onToggle;

  const ToggleActivity(
      {Key? key, required this.activity, required this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      value: activity.isDone,
      title: Text(
        activity.name,
        style: theme.textTheme.headline4?.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
      onChanged: onToggle,
    );
  }
}
