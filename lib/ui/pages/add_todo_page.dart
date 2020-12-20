import 'package:flutter/material.dart';
import 'package:keep_at_hand/models/todo_model.dart';
import 'package:keep_at_hand/service/db_todo.dart';

class AddToDoPage extends StatefulWidget {
  final ToDo todo;

  AddToDoPage({this.todo});

  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  TextEditingController title;

  @override
  void initState() {
    title = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Добавить задачу"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              //setState(() {});
              save();
            },
          ),
        ],
      ),
      body: TextField(
        controller: title,
      ),
    );
  }

  Future<void> save() async {
    if (title.text != '') {
      widget.todo.title = title.text;
      await dataBase_todo().add(widget.todo);
    }
  }
}
