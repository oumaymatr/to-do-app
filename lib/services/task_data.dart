import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp_flutter/services/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'tasks';
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);
  int get taskCount => _tasks.length;

  Future<void> fetchTasks() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection(_collectionName).get();
    _tasks = querySnapshot.docs
        .map((doc) => Task(id: doc.id, name: doc['name'], isDone: doc['done']))
        .toList();
    notifyListeners();
  }

  Future<void> addTask(String newTaskTitle) async {
    try {
      String taskId = UniqueKey().toString(); // Generate unique ID
      await _firestore.collection(_collectionName).doc(taskId).set({
        'id': taskId,
        'name': newTaskTitle,
        'done': false,
      });
      notifyListeners();
      await fetchTasks();
    } catch (e) {
      print('Error adding task: $e');
      // Handle error gracefully
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      print('Updating task with id: ${task.id}');
      await _firestore
          .collection(_collectionName)
          .doc(task.id)
          .update({'done': !task.isDone});
      await fetchTasks(); // Refresh local tasks after updating
    } catch (e) {
      print('Error updating task: $e');
      // Handle error gracefully
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _firestore.collection(_collectionName).doc(task.id).delete();
      await fetchTasks();
    } catch (e) {
      print("Error deleting task: $e");
    } // Refresh local tasks after deletion
  }

  Future<void> modifyTask(String taskId, String newTaskTitle) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(taskId)
          .update({'name': newTaskTitle});
      await fetchTasks();
    } catch (e) {
      print("Error modifying task: $e");
    } // Refresh local tasks after modification
  }
}
