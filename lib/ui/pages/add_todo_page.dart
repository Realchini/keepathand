import 'package:flutter/material.dart';
import 'package:keep_at_hand/models/todo_list_model.dart';

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
              setState(() {});
              save();
              editMode = true;
            },
          ),
        ],
      ),
    );
  }
}
