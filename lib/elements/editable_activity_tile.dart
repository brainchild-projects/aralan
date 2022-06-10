import 'package:aralan/elements/activity_dialog.dart';
import 'package:flutter/material.dart';

import '../models/activity.dart';

typedef OnChangeActivity = void Function(Activity activity);

class EditableActivityTile extends StatelessWidget {
  final Activity activity;
  final OnChangeActivity onChange;

  const EditableActivityTile({
    Key? key,
    required this.activity,
    required this.onChange,
  }) : super(key: key);

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
      leading: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          final updated = await ActivityDialog.open(context, activity);
          if (updated != null) {
            onChange(updated);
          }
        },
      ),
    );
  }
}
