import 'package:flutter/material.dart';

import '../models/activity.dart';

class ActivityDialog extends StatefulWidget {
  final Activity activity;
  const ActivityDialog({Key? key, required this.activity}) : super(key: key);

  static Future<Activity?> open(BuildContext context, Activity activity) {
    return showDialog(
      context: context,
      builder: (context) => ActivityDialog(activity: activity),
    );
  }

  @override
  State<ActivityDialog> createState() => _ActivityDialogState();
}

class _ActivityDialogState extends State<ActivityDialog> {
  late Activity activity;

  @override
  initState() {
    super.initState();
    activity = widget.activity;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Activity'),
      content: TextFormField(
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter activity name'),
        initialValue: activity.name,
        onChanged: (str) {
          setState(() {
            activity = activity.update(name: str);
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () => submit(context),
          child: const Text('SAVE'),
        ),
      ],
    );
  }

  void submit(BuildContext context) {
    Navigator.of(context).pop<Activity?>(activity);
  }
}
