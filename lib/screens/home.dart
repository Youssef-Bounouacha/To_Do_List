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
  List<Tasks> _foundTasks = [];
  final _taskController = TextEditingController();
  String _selectedFilter = 'all';

  @override
  void initState() {
    _foundTasks = taskList;
    super.initState();
  }

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
                          'Tasks List',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Tasks tassk in _foundTasks)
                        ToDoItems(
                          task: tassk,
                          onTaskChange: _handleTaskChange,
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

  void _runFilter(String enteredKeyword) {
    List<Tasks> results = [];
    if (enteredKeyword.isEmpty) {
      results = taskList;
    } else {
      results = taskList
          .where((item) => item.tasksText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTasks = results;
    });
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
        onChanged: (value) {
          _runFilter(value);
        },
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
      title: Text('To Do App'),
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
