import 'package:aralan/elements/activity_dialog.dart';
import 'package:aralan/elements/choose_and_order_activities.dart';
import 'package:aralan/elements/editable_activity_tile.dart';
import 'package:aralan/elements/list_container.dart';
import 'package:aralan/elements/navigation_button.dart';
import 'package:aralan/models/activities_today.dart';
import 'package:aralan/models/activity_repository.dart';
import 'package:aralan/models/weekdays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../elements/h2.dart';
import '../models/activity.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final repo = Provider.of<ActivityRepository>(context);
    final allActivities = repo.all();
    final now = DateTime.now();

    onChooseActivitiesToday(activities) {
      repo.updateActivitiesToday(
        ActivitiesToday.fromPlainActivities(
          now,
          activities,
        ),
      );
    }

    onChooseDailyActivities(int weekday) {
      return (activities) {
        repo.updateForWeekday(
          weekday,
          activities,
        );
      };
    }

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const H2('All Activities'),
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
                            TextButton(
                              onPressed: () async {
                                final newActivity = await ActivityDialog.open(
                                    context, Activity(name: ''));
                                if (newActivity is Activity) {
                                  repo.add(newActivity);
                                }
                              },
                              child: const Text('Add an Activity'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const H2('Day Activities'),
                            ChooseAndOrderActivities(
                              title: 'Activities Today',
                              list: repo.activitiesToday(now).plainActivities(),
                              onChoose: onChooseActivitiesToday,
                              available: allActivities,
                            ),
                            ...(weekdays.keys.map((weekday) {
                              return ChooseAndOrderActivities(
                                title: weekdays[weekday].toString(),
                                list: repo.forWeekday(weekday),
                                available: allActivities,
                                onChoose: onChooseDailyActivities(weekday),
                              );
                            })),
                          ],
                        ),
                      )
                    ],
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
