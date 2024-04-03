import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {super.key,
      this.isChecked,
      required this.taskTitle,
      required this.checkBoxCallback,
      required this.modifyCallback,
      required this.deleteCallback});
  final bool? isChecked;
  final String taskTitle;
  final Function(bool?) checkBoxCallback;
  final Function() modifyCallback;

  final Function() deleteCallback;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
              onPressed: (context) => {deleteCallback()},
              backgroundColor: Colors.pink,
              icon: Icons.delete_forever),
          SlidableAction(
              onPressed: (context) => {modifyCallback()},
              foregroundColor: Colors.white,
              backgroundColor: Colors.greenAccent,
              icon: Icons.edit),
        ],
      ),
      child: ListTile(
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
      ),
    );
  }
}
