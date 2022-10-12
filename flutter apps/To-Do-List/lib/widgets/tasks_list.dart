import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtd/models/task.dart';
import 'package:wtd/models/task_data.dart';
import 'package:wtd/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        if (taskData.taskCount == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Wow! Such Empty',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Use the `+` Icon to add a task',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: taskData.taskCount,
                itemBuilder: (context, index) {
                  final Task task = taskData.tasks[index];
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onLongPress: () => taskData.deleteTask(index),
                    child: TaskTile(
                      taskName: task.taskName,
                      isChecked: task.completionStatus,
                      checkBoxCallback: (value) {
                        taskData.updateTask(task);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Divider(
              thickness: 1,
              color: Colors.lightBlueAccent,
            ),
            const SizedBox(height: 6),
            Text(
              'Hold a task to delete it',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'HAPPY \'TASKING\'!',
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        );
      },
    );
  }
}
