class Task {
  Task({required this.id, required this.name, this.isDone = false});
  late String id;
  late String name;
  late bool isDone;
  void toggleDone() {
    isDone = !isDone;
  }
}
