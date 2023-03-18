class Tasks {
  String? id;
  String? tasksText;
  bool isDone;

  Tasks({required this.id, required this.tasksText, this.isDone = false});

  static List<Tasks> tasksList() {
    return [
      Tasks(id: '1', tasksText: 'Morning Excercise', isDone: false),
      Tasks(id: '2', tasksText: 'Buy Groceries', isDone: true),
      Tasks(id: '3', tasksText: 'Check Email', isDone: false),
      Tasks(id: '4', tasksText: 'Team Meeting', isDone: false),
    ];
  }
}
