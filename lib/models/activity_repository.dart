import 'dart:convert';

import 'package:aralan/models/activities_today.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'activity.dart';

const allActivities = 'all_activities';
const keyActivitiesToday = 'activities_today';

final List<Activity> _defaultActivities = [
  Activity(name: 'Flag Ceremony'),
  Activity(name: 'Exercise'),
  Activity(name: 'Worksheets'),
  Activity(name: 'Khan Academy Kids'),
  Activity(name: 'Reading'),
  Activity(name: 'Computer Work'),
];

class ActivityRepository extends ChangeNotifier {
  Map<String, Activity> _activitiesCache = {};
  final SharedPreferences _prefs;

  ActivityRepository(this._prefs) {
    final jsonData = _prefs.getString(allActivities);
    if (jsonData != null) {
      _activitiesCache = _activitiesFromParsed(json.decode(jsonData));
    } else {
      for (var activity in _defaultActivities) {
        _activitiesCache[activity.id] = activity;
      }
      _updateStore();
    }
  }

  Map<String, Activity> _activitiesFromParsed(List<dynamic> raw) {
    final map = <String, Activity>{};
    for (var obj in raw) {
      final activity = Activity.fromObject(obj);
      map[activity.id] = activity;
    }
    return map;
  }

  List<Activity> all() {
    return _activitiesCache.values.toList();
  }

  List<CheckableActivity> allCheckable() {
    return _wrapWithCheckable(all());
  }

  List<CheckableActivity> _wrapWithCheckable(List<Activity> list) {
    return list
        .map((activity) => CheckableActivity(activity: activity))
        .toList();
  }

  add(Activity activity) {
    _activitiesCache[activity.id] = activity;
    _updateStore();
  }

  _updateStore() {
    _prefs.setString(allActivities, json.encode(_activitiesCacheToJSON()));
    notifyListeners();
  }

  List<Map<String, dynamic>> _activitiesCacheToJSON() {
    return all().map((activity) => activity.toJSON()).toList();
  }

  remove(Activity activity) {
    _activitiesCache.remove(activity.id);
    _updateStore();
  }

  update(Activity activity) {
    _activitiesCache[activity.id] = activity;
    _updateStore();
  }

  List<Activity> forWeekday(int weekday) {
    final ids = _prefs.getStringList(_weekDayKey(weekday));
    if (ids != null) {
      return ids
          .map((id) => _activitiesCache[id])
          .whereType<Activity>()
          .toList();
    }
    return [];
  }

  ActivitiesToday activitiesToday(DateTime now) {
    final stored = _prefs.getString(keyActivitiesToday);
    // If the date is the same get it
    if (stored != null) {
      final storedToday = ActivitiesToday.fromObject(jsonDecode(stored));
      if (storedToday.isForSameDay(now) && !storedToday.isEmpty()) {
        return storedToday;
      }
    }
    // Else generate it
    final actsToday = ActivitiesToday.fromPlainActivities(
      now,
      forWeekday(now.weekday),
    );
    _updateActivitiesToday(actsToday);
    return actsToday;
  }

  _updateActivitiesToday(ActivitiesToday actsToday) {
    _prefs.setString(keyActivitiesToday, json.encode(actsToday.toJSON()));
  }

  toggleActivityToday(CheckableActivity activity, DateTime now) {
    final actsToday = activitiesToday(now);
    actsToday.toggleActivity(activity);
    _updateActivitiesToday(actsToday);
    notifyListeners();
  }

  updateActivitiesToday(ActivitiesToday actsToday) {
    _updateActivitiesToday(actsToday);
    notifyListeners();
  }

  List<CheckableActivity> checkableForWeekday(int weekday) {
    return _wrapWithCheckable(forWeekday(weekday));
  }

  _updateWeekdayList(int weekday, List<Activity> activities) {
    final ids = activities.map((activity) => activity.id).toList();
    _prefs.setStringList(_weekDayKey(weekday), ids);
    notifyListeners();
  }

  List<Activity> updateForWeekday(int weekday, List<Activity> activities) {
    _updateWeekdayList(weekday, activities);
    return activities;
  }

  List<Activity> addForWeekday(int weekday, Activity activity) {
    final activities = forWeekday(weekday);
    activities.add(activity);
    _updateWeekdayList(weekday, activities);
    return activities;
  }

  List<Activity> removeFromWeekday(int weekday, Activity activity) {
    final activities = forWeekday(weekday);
    activities.removeWhere((current) => current.id == activity.id);
    _updateWeekdayList(weekday, activities);
    return activities;
  }

  String _weekDayKey(int weekday) {
    return "day-$weekday";
  }
}
