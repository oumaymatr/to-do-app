import 'package:flutter/material.dart';
import 'package:todoapp_flutter/screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_flutter/services/task_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
      ),
    );
  }
}
