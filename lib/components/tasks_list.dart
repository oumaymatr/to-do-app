import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:todoapp_flutter/services/task_data.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
              taskTitle: taskData.tasks[index].name,
              isChecked: taskData.tasks[index].isDone,
              checkBoxCallback: (checkboxState) => {
                taskData.updateTask(
                  taskData.tasks[index],
                ),
              },
              deleteCallback: () => {
                taskData.deleteTask(
                  taskData.tasks[index],
                ),
              },
              modifyCallback: () => _showModifyDialog(context, taskData, index),
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}

void _showModifyDialog(BuildContext context, TaskData taskData, int index) {
  TextEditingController controller = TextEditingController();
  controller.text = taskData.tasks[index].name;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Modify Task"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter new task name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),
          TextButton(
            onPressed: () {
              String newTaskTitle = controller.text.trim();
              if (newTaskTitle.isNotEmpty) {
                taskData.modifyTask(index, newTaskTitle);
                Navigator.of(context).pop(); // Close the dialog
              }
            },
            child:
                const Text("Modify", style: TextStyle(color: Colors.lightBlue)),
          ),
        ],
      );
    },
  );
}
