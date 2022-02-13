import 'dart:collection';

import 'package:aralan/models/activity.dart';
import 'package:flutter/foundation.dart';

final List<Activity> _allActivities = [
  Activity(name: 'Flag Ceremony'),
  Activity(name: 'Exercise'),
  Activity(name: 'Worksheets'),
  Activity(name: 'Khan Academy Kids'),
  Activity(name: 'Reading'),
  // Activity(name: 'Physical Education (P.E.)'),
  Activity(name: 'Computer Work'),
];

UnmodifiableListView<Activity> filteredActivities() {
  final today = DateTime.now().weekday;
  return UnmodifiableListView(_allActivities.where((activity) {
    if (activity.name == 'Flag Ceremony') {
      return today == DateTime.monday;
    }
    return true;
  }));
}

class ActivityListData extends ChangeNotifier {
  UnmodifiableListView<Activity> get activities {
    return filteredActivities();
  }

  add(Activity activity) {
    _allActivities.add(activity);
    notifyListeners();
  }

  remove(Activity activity) {
    _allActivities.remove(activity);
    notifyListeners();
  }

  toggleActivity(Activity activity) {
    activity.toggleDone();
    notifyListeners();
  }

  int get length => filteredActivities().length;
  operator [](int i) => filteredActivities()[i];
  operator []=(int i, Activity activity) => _allActivities[i] = activity;
}
