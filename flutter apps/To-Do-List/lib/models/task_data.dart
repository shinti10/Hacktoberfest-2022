import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtd/models/task.dart';

class TaskData extends ChangeNotifier {
  SharedPreferences preferences;
  TaskData(this.preferences);
  final List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return tasks.length;
  }

  void addTask(String taskName) async {
    _tasks.add(Task(taskName: taskName));
    notifyListeners();
    _addToPrefs();
  }

  void updateTask(Task task) async {
    task.toggleDone();
    notifyListeners();
    _addToPrefs();
  }

  void deleteTask(int taskIndex) {
    _tasks.removeAt(taskIndex);
    notifyListeners();
    _addToPrefs();
  }

  void instantiateTasks(String tasksJSON) {
    if (tasksJSON.isNotEmpty) {
      for (var item in jsonDecode(tasksJSON)) {
        _tasks.add(Task(
            taskName: item['taskName'],
            completionStatus: item['isCompleted'] ?? false));
      }
      notifyListeners();
    }
  }

  void _addToPrefs() async {
    await preferences.setString(
        'tasks',
        jsonEncode(_tasks
            .map((task) => {
                  'taskName': task.taskName,
                  'isCompleted': task.completionStatus
                })
            .toList()));
  }
}
