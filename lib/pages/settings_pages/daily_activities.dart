import 'package:aralan/elements/choose_and_order_activities.dart';
import 'package:aralan/models/activity_repository.dart';
import 'package:aralan/models/weekdays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyActivities extends StatelessWidget {
  const DailyActivities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<ActivityRepository>(context);
    final allActivities = repo.all();

    onChooseDailyActivities(int weekday) {
      return (activities) {
        repo.updateForWeekday(
          weekday,
          activities,
        );
      };
    }

    return Column(
      children: weekdays.keys.map((weekday) {
        return ChooseAndOrderActivities(
          title: weekdays[weekday].toString(),
          list: repo.forWeekday(weekday),
          available: allActivities,
          onChoose: onChooseDailyActivities(weekday),
        );
      }).toList(),
    );
  }
}
