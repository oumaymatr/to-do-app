import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/components/tasks_list.dart';
import 'add_task_screen.dart';
import 'package:todoapp_flutter/services/task_data.dart';
import 'package:todoapp_flutter/services/localization.dart';

bool isChecked = false;

class TaskScreen extends StatefulWidget {
  final Locale locale;
  const TaskScreen({super.key, required this.locale});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = Localization(widget.locale);
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskScreen(locale: widget.locale),
          ),
        },
        backgroundColor: Colors.lightBlueAccent,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Hero(
                  tag: 'logo',
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.check,
                      size: 55,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "ToDoList",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  localization.tasks(Provider.of<TaskData>(context).taskCount)!,
                  //"${Provider.of<TaskData>(context).taskCount} tasks",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const TasksList(),
            ),
          )
        ],
      ),
    );
  }
}
