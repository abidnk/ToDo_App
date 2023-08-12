import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/db/functions.dart';
import 'package:todo_app/screen/completed.dart';
import 'package:todo_app/screen/todo_tile.dart';

import 'dialog_box.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _mybox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createinitialData();
     
    } else {
      db.loadData();
    }

    // TODO: implement initState
    super.initState();
  }

  //Text controller

  final _controller = TextEditingController();

  // List of todo task
  // List toDoList = [
  //   ["Make Tutorial", false],
  //   ["Do Exercise", false]
  // ];

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      //  toDoList[index][1] = !toDoList[index][1];
    });
    // db.updateDatabase();
    
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      //  toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //create a new task
  void createNewtask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _controller,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      // toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
            title: Text(
              "TO DO",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompletedTask(),
                    ));
                  })
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewtask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          // itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              // taskName: toDoList[index][0],
              taskcompleted: db.toDoList[index][1],
              // taskcompleted: toDoList[index][1],
              onChanged: ((value) => checkBoxChanged(value, index)),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
