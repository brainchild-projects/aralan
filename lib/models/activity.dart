import 'package:uuid/uuid.dart';

const uuid = Uuid();

abstract class ActivityLike {
  String get name;
  String get id;
}

class Activity extends ActivityLike {
  final String name;
  final String id;

  Activity({required this.name, String? id}) : id = id ?? uuid.v4();

  Activity.fromObject(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJSON() => {
        'name': name,
        'id': id,
      };
}

class CheckableActivity extends ActivityLike {
  final Activity activity;
  bool isDone;

  CheckableActivity({required this.activity, this.isDone = false});

  CheckableActivity.fromObject(Map<String, dynamic> json)
      : activity = Activity.fromObject(json),
        isDone = json['isDone'];

  Map<String, dynamic> toJSON() => {
        'name': name,
        'id': id,
        'isDone': isDone,
      };

  @override
  String get id => activity.id;

  @override
  String get name => activity.name;

  bool toggleDone() {
    isDone = !isDone;
    return isDone;
  }
}
