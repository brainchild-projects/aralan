class Activity {
  final String name;
  bool isDone;

  Activity({required this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
