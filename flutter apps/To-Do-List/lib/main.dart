import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtd/models/task_data.dart';
import 'package:wtd/screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String tasksJSON = preferences.getString('tasks') ?? '';
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        TaskData data = TaskData(preferences);
        data.instantiateTasks(tasksJSON);
        return data;
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    ),
  );
}
