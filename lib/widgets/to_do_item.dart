import 'package:flutter/material.dart';
import 'package:my_first_app/model/tasks.dart';

class ToDoItems extends StatelessWidget {
  final Tasks task;
  final onTaskChange;
  final Function onUpdate;
  final Function onDelete;

  ToDoItems({
    Key? key,
    required this.task,
    required this.onTaskChange,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete(task),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            onTaskChange(task);
          },
          onLongPress: () {
            onUpdate(task);
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
        ),
      ),
    );
  }
}
