import 'package:aralan/elements/toggle_activity.dart';
import 'package:flutter/material.dart';

import '../models/activity.dart';
import 'editable_activity.dart';
import 'h3.dart';
import 'list_container.dart';

typedef OnChooseActivities = Function(List<Activity> activity);

class EditActivities extends StatefulWidget {
  final List<Activity> list;
  final OnChooseActivities onChoose;
  final List<Activity> available;
  final String? title;
  const EditActivities({
    Key? key,
    required this.list,
    required this.onChoose,
    required this.available,
    required this.title,
  }) : super(key: key);

  @override
  State<EditActivities> createState() => _EditActivitiesState();
}

class _EditActivitiesState extends State<EditActivities> {
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
    var theme = Theme.of(context);
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
    final body = ListContainer<Activity>(
      list: widget.list,
      onReorder: (a, b) {
        setState(() {
          final tempList = _selectedActivities.toList();
          final removed = tempList.removeAt(a);
          tempList.insert(b, removed);
          _selectedActivities = Set.from(tempList);
          widget.onChoose(_chosenActivities());
        });
      },
      builder: (activity, _) {
        return EditableActivity(
          key: Key(activity.id),
          activity: activity,
        );
      },
    );
    final action = IconButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => builder);
      },
      color: theme.colorScheme.primary,
      icon: const Icon(Icons.add),
    );

    final cells = widget.title != null
        ? [H3(widget.title!), body, action]
        : [body, action];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cells,
    );
  }
}
