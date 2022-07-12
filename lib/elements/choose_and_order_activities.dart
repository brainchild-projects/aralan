import 'package:aralan/elements/toggle_activity.dart';
import 'package:aralan/tools/reorder.dart';
import 'package:flutter/material.dart';

import '../models/activity.dart';
import 'activity_list_tile.dart';
import 'h2.dart';
import 'list_container.dart';

typedef OnChooseActivities = Function(List<Activity> activity);

class ChooseAndOrderActivities extends StatefulWidget {
  final List<Activity> list;
  final OnChooseActivities onChoose;
  final List<Activity> available;
  final String? title;
  const ChooseAndOrderActivities({
    Key? key,
    required this.list,
    required this.onChoose,
    required this.available,
    required this.title,
  }) : super(key: key);

  @override
  State<ChooseAndOrderActivities> createState() =>
      _ChooseAndOrderActivitiesState();
}

class _ChooseAndOrderActivitiesState extends State<ChooseAndOrderActivities> {
  Set<String> _selectedActivities = {};

  @override
  void initState() {
    super.initState();
    _selectedActivities = Set<String>.from(
      widget.list.map((activity) => activity.id),
    );
  }

  List<Activity> _chosenActivities() {
    return _selectedActivities
        .map(
          (id) => widget.available.firstWhere((activity) => activity.id == id),
        )
        .whereType<Activity>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final builder = StatefulBuilder(builder: (context, setDialogState) {
      final toggles = widget.available.map((activity) {
        return ToggleActivity(
          activity: CheckableActivity(
            activity: activity,
            isDone: _selectedActivities.contains(activity.id),
          ),
          onToggle: (isIncluded) {
            setDialogState(() {
              if (isIncluded == true) {
                _selectedActivities.add(activity.id);
              } else {
                _selectedActivities.remove(activity.id);
              }
            });
          },
        );
      }).toList();
      return SimpleDialog(
        title: const Text("Choose Activities"),
        children: [
          ...toggles,
          Center(
            child: TextButton(
              child: const Text('Done'),
              onPressed: () {
                setDialogState(() {
                  widget.onChoose(_chosenActivities());
                });
                Navigator.pop(context, true);
              },
            ),
          )
        ],
      );
    });
    final body = _body();
    final action = _action(theme, builder);
    final title = widget.title;
    const spacer = SizedBox(height: 6.0);

    final cells = title != null
        ? [
            H2(title),
            const SizedBox(height: 20.0),
            body,
            spacer,
            action,
          ]
        : [body, spacer, action];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: cells,
      ),
    );
  }

  Widget _body() {
    return Card(
      child: ListContainer<Activity>(
        list: widget.list,
        onReorder: (a, b) {
          setState(() {
            final tempList = _selectedActivities.toList();
            _selectedActivities = Set.from(reorder(tempList, a, b));
            widget.onChoose(_chosenActivities());
          });
        },
        builder: (activity, _, index) {
          return ActivityListTile(
            key: Key(activity.id),
            activity: activity,
          );
        },
      ),
    );
  }

  Widget _action(ThemeData theme, StatefulBuilder builder) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => builder);
      },
      // color: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.primary,
      child: const Icon(Icons.add),
      heroTag: widget.title,
    );
  }
}
