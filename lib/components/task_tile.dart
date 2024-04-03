import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {super.key,
      this.isChecked,
      required this.taskTitle,
      required this.checkBoxCallback,
      required this.longPressCallback});
  final bool? isChecked;
  final String taskTitle;
  final Function(bool?) checkBoxCallback;
  final Function() longPressCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ?? false ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlue,
        value: isChecked,
        onChanged: checkBoxCallback,
      ),
    );
  }
}
