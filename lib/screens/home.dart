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

  @override
  Widget build(BuildContext context) {
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
                      for (Tasks taskk in taskList)
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
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          hintText: 'Add a new task',
                          border: InputBorder.none,
                        ),
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _addTask(_taskController.text);
                      },
                      child: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        padding: EdgeInsets.all(20),
                      ),
                    )),
              ],
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
    setState(() {
      taskList.add(Tasks(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        tasksText: task,
      ));
    });
    _taskController.clear();
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text('To Do List'),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
            ),
          ],
        ));
  }
}
