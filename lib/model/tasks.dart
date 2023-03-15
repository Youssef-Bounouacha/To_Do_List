class Tasks {
  String? id;
  String? tasksText;
  bool isDone;

  Tasks({required this.id, required this.tasksText, this.isDone = false});

  static List<Tasks> tasksList() {
    return [
      Tasks(id: '1', tasksText: 'Buy Milk', isDone: true),
      Tasks(id: '2', tasksText: 'Buy Bread', isDone: true),
      Tasks(id: '3', tasksText: 'Buy Beef', isDone: false),
      Tasks(id: '4', tasksText: 'Buy Pork', isDone: false),
    ];
  }
}
