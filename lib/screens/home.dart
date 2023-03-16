import 'package:flutter/material.dart';
import '../widgets/to_do_item.dart';
import '../model/tasks.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final taskList = Tasks.tasksList();
  final _taskController = TextEditingController();
  String _selectedFilter = 'all';
  @override
  Widget build(BuildContext context) {
    List<Tasks> filteredTasks = [];

    if (_selectedFilter == 'done') {
      filteredTasks = taskList.where((task) => task.isDone).toList();
    } else if (_selectedFilter == 'inProgress') {
      filteredTasks = taskList.where((task) => !task.isDone).toList();
    } else {
      filteredTasks = taskList;
    }
    ;
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                searchbox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'Tasks',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Tasks taskk in filteredTasks)
                        ToDoItems(
                          task: taskk,
                          onTaskChange: _handleTaskChange,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Add a new task'),
                      content: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          hintText: 'Enter task name',
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                            style: TextButton.styleFrom(
                              primary: Colors.teal,
                            )),
                        ElevatedButton(
                          onPressed: () {
                            _addTask(_taskController.text);
                            Navigator.pop(context);
                          },
                          child: Text('Add'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0), // set border radius
                ),
                child: Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleTaskChange(Tasks task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        taskList.add(Tasks(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          tasksText: task,
        ));
      });
      _taskController.clear();
    }
  }

  Widget searchbox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: 'Enter a task',
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey[700],
      title: Text('To Do List'),
      actions: [
        DropdownButton<String>(
          onChanged: (value) {
            setState(() {
              _selectedFilter = value!;
            });
          },
          value: _selectedFilter,
          dropdownColor: Colors.blueGrey[700],
          alignment: Alignment.center,
          iconEnabledColor: Colors.white,
          items: [
            DropdownMenuItem(
              value: 'all',
              child: Text('All', style: TextStyle(color: Colors.white)),
            ),
            DropdownMenuItem(
              value: 'done',
              child: Text('Done', style: TextStyle(color: Colors.white)),
            ),
            DropdownMenuItem(
              value: 'inProgress',
              child: Text('In Progress', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}
