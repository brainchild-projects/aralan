import 'package:aralan/elements/edit_activities.dart';
import 'package:aralan/elements/editable_activity.dart';
import 'package:aralan/elements/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'elements/h2.dart';
import 'elements/list_container.dart';
import 'models/activities_today.dart';
import 'models/activity.dart';
import 'models/activity_repository.dart';
import 'models/weekdays.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final repo = Provider.of<ActivityRepository>(context);
    final allActivities = repo.all();
    final now = DateTime.now();

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
                              builder: (activity, context) {
                                return EditableActivity(
                                  activity: activity,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const H2('Day Activities'),
                            EditActivities(
                              title: 'Activities Today',
                              list: repo.activitiesToday(now).plainActivities(),
                              onChoose: (activities) {
                                repo.updateActivitiesToday(
                                  ActivitiesToday.fromPlainActivities(
                                    now,
                                    activities,
                                  ),
                                );
                              },
                              available: allActivities,
                            ),
                            ...(weekdays.keys.map((weekday) {
                              return EditActivities(
                                title: weekdays[weekday].toString(),
                                list: repo.forWeekday(weekday),
                                available: allActivities,
                                onChoose: (activities) {
                                  repo.updateForWeekday(
                                    weekday,
                                    activities,
                                  );
                                },
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
