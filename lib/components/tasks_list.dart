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
              longPressCallback: () => {
                taskData.deleteTask(
                  taskData.tasks[index],
                ),
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
