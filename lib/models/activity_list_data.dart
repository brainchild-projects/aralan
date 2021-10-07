import 'dart:collection';

import 'package:aralan/models/activity.dart';
import 'package:flutter/foundation.dart';

class ActivityListData extends ChangeNotifier {
  final List<Activity> _activities = [
    Activity(name: 'Exercise'),
    Activity(name: 'Reading'),
    Activity(name: 'Worksheet'),
    // Activity(name: 'Physical Education (P.E.)'),
    Activity(name: 'Computer'),
  ];

  UnmodifiableListView<Activity> get activities {
    return UnmodifiableListView(_activities);
  }

  add(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  remove(Activity activity) {
    _activities.remove(activity);
    notifyListeners();
  }

  toggleActivity(Activity activity) {
    activity.toggleDone();
    notifyListeners();
  }

  int get length => _activities.length;
  operator [](int i) => _activities[i];
  operator []=(int i, Activity activity) => _activities[i] = activity;
}
