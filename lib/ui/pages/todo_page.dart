import 'package:flutter/material.dart';
import 'package:keep_at_hand/models/todo_list_model.dart';

class ToDoPage extends StatefulWidget {
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {

  bool checkingValue = false;
  List<ToDo> todos;

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Список дел"),
      ),
      body: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text("test checkbox"),
        value: checkingValue,
        onChanged: (newValue) {setState(() {checkingValue = newValue;});},
      ),
    );
  }
}
