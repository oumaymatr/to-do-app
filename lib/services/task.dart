class Task {
  Task({required this.name, this.isDone = false});
  late String name;
  late bool isDone;
  void toggleDone() {
    isDone = !isDone;
  }
}
