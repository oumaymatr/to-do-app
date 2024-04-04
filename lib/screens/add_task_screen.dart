import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_flutter/services/task_data.dart';
import 'package:todoapp_flutter/services/localization.dart';

class AddTaskScreen extends StatefulWidget {
  final Locale locale;
  const AddTaskScreen({super.key, required this.locale});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTaskTitle = '';
  @override
  Widget build(BuildContext context) {
    final localization = Localization(widget.locale);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            localization.addTask!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.lightBlue, fontSize: 30),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) {
              setState(() {
                newTaskTitle = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                elevation: 10,
                shape: const RoundedRectangleBorder(),
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Provider.of<TaskData>(context, listen: false)
                    .addTask(newTaskTitle);
                Navigator.pop(context);
              },
              child: Text(localization.add!),
            ),
          )
        ],
      ),
    );
  }
}
