import 'package:date_format/date_format.dart';

import 'activity.dart';

String todayKeyFromDate(DateTime date) =>
    formatDate(date, ['yyyy', '-', 'm', '-', 'd']);

class ActivitiesToday {
  final String todayKey;
  final List<CheckableActivity> activities;

  const ActivitiesToday(this.todayKey, this.activities);

  factory ActivitiesToday.fromDateTime(
    DateTime now,
    List<CheckableActivity> activities,
  ) {
    final todayKey = todayKeyFromDate(now);
    return ActivitiesToday(todayKey, activities);
  }

  factory ActivitiesToday.fromPlainActivities(
    DateTime now,
    List<Activity> activities,
  ) {
    return ActivitiesToday.fromDateTime(
      now,
      activities.map((act) => CheckableActivity(activity: act)).toList(),
    );
  }

  factory ActivitiesToday.fromObject(Map<String, dynamic> json) {
    final todayKey = json['todayKey'];
    final activities = (json['activities'] as List<dynamic>)
        .map((element) => CheckableActivity.fromObject(element))
        .toList();
    return ActivitiesToday(todayKey, activities);
  }

  ActivitiesToday mapDone(List<CheckableActivity> checkedActivities) {
    final newActivities = activities.map((activity) {
      final before = checkedActivities.firstWhere(
        (element) => element.id == activity.id,
        orElse: () =>
            CheckableActivity(activity: Activity(name: '', id: 'none')),
      );
      if (before.id == 'none') {
        return activity;
      }
      activity.isDone = before.isDone;
      return activity;
    }).toList();
    return ActivitiesToday(
      todayKey,
      newActivities,
    );
  }

  Map<String, dynamic> toJSON() {
    final activitiesJSON =
        activities.map((activity) => activity.toJSON()).toList();
    return {
      'todayKey': todayKey,
      'activities': activitiesJSON,
    };
  }

  bool isForSameDay(DateTime now) {
    return todayKeyFromDate(now) == todayKey;
  }

  bool isEmpty() {
    return activities.isEmpty;
  }

  toggleActivity(CheckableActivity activity) {
    final toToggle =
        activities.firstWhere((current) => current.id == activity.id);
    toToggle.toggleDone();
  }

  List<Activity> plainActivities() {
    return activities.map((current) => current.activity).toList();
  }
}
