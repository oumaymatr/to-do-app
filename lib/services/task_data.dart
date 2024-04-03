import 'package:flutter/foundation.dart';
import 'package:todoapp_flutter/services/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(name: "Study"),
    Task(name: "Have lunch"),
    Task(name: "Go to the gym"),
  ];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);
  int get taskCount => _tasks.length;

  void addTask(String newTaskTitle) {
    _tasks.add(
      Task(name: newTaskTitle),
    );
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
