import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference our Box
  final _myBox = Hive.box("mybox");

  //First time opening the App
  void createinitialData() {
    toDoList = [
      ["Start Making ToDo", false],
      ["Enjoy My App", false]
    ];
  }
  //load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }
  //when updating

  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
