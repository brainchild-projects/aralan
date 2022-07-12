import 'package:aralan/elements/choose_and_order_activities.dart';
import 'package:aralan/models/activities_today.dart';
import 'package:aralan/models/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodaysActivities extends StatelessWidget {
  const TodaysActivities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<ActivityRepository>(context);
    final now = DateTime.now();
    final allActivities = repo.all();
    onChooseActivitiesToday(activities) {
      repo.updateActivitiesToday(
        ActivitiesToday.fromPlainActivities(
          now,
          activities,
        ),
      );
    }

    return ChooseAndOrderActivities(
      title: 'Activities Today',
      list: repo.activitiesToday(now).plainActivities(),
      onChoose: onChooseActivitiesToday,
      available: allActivities,
    );
  }
}
