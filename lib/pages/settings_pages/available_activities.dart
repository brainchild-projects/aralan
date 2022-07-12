import 'package:aralan/elements/activity_dialog.dart';
import 'package:aralan/elements/editable_activity_tile.dart';
import 'package:aralan/elements/h2.dart';
import 'package:aralan/elements/list_container.dart';
import 'package:aralan/models/activity.dart';
import 'package:aralan/models/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableActivities extends StatelessWidget {
  const AvailableActivities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final repo = Provider.of<ActivityRepository>(context);
    final allActivities = repo.all();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const H2('All Activities'),
          Card(
            child: Column(
              children: [
                ListContainer<Activity>(
                  list: allActivities,
                  builder: (activity, context, _) {
                    return EditableActivityTile(
                        activity: activity,
                        onChange: (activity) {
                          // debugPrint('Edited: ${activity.name}');
                          repo.update(activity);
                        });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 6.0),
          FloatingActionButton(
            onPressed: () async {
              final newActivity =
                  await ActivityDialog.open(context, Activity(name: ''));
              if (newActivity is Activity) {
                repo.add(newActivity);
              }
            },
            backgroundColor: theme.colorScheme.primary,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
