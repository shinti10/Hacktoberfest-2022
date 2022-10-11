import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isChecked;
  final Function(bool?)? checkBoxCallback;

  const TaskTile({
    required this.taskName,
    this.isChecked = false,
    this.checkBoxCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskName,
          style: TextStyle(
              color: isChecked ? Colors.grey.shade600 : Colors.black,
              decoration: isChecked
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkBoxCallback,
      ),
    );
  }
}
