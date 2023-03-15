import 'package:flutter/material.dart';
import 'package:my_first_app/model/tasks.dart';

class ToDoItems extends StatelessWidget {
  final Tasks task;
  final onTaskChange;

  ToDoItems({Key? key, required this.task, required this.onTaskChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            onTaskChange(task);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: Colors.white,
          leading: Icon(
            task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.teal,
          ),
          title: Text(
            task.tasksText!,
            style: TextStyle(
              fontSize: 18,
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        ));
  }
}
