import 'package:flutter/material.dart';
import 'package:keep_at_hand/models/todo_model.dart';
import 'package:keep_at_hand/service/db_todo.dart';
import 'package:keep_at_hand/ui/views/loading.dart';

class ToDoPage extends StatefulWidget {
  final ToDo todo;
  ToDoPage({this.todo});

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  //bool checkingValue = false;
  bool loading = true;
  List<ToDo> todos = [];
  TextEditingController titleField;
  TextEditingController testtitle;

  // @override
  // void setState(fn) {
  //   super.setState(fn);
  //   refresh();
  // }

  @override
  void initState() {
    super.initState();
    titleField = new TextEditingController();
    testtitle = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Список дел"),
        ),
        body: /*loading
            ? Loading()
            : */

            Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(child: TextField(controller: titleField,)),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {});
                    save();
                    //save();},
                  }
                ),
              ),
              Expanded(child: TextField(controller: testtitle,)),
            ]),
            Expanded(
              child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    ToDo todo = todos[index];
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(todo.title),
                      value: todo.value,
                      onChanged: (newValue) {
                        setState(() {
                          todo.value = newValue;
                        });
                      },
                    );
                  }),
            ),
          ],
        )
        // CheckboxListTile(
        //   controlAffinity: ListTileControlAffinity.leading,
        //   title: Text("test checkbox"),
        //   value: checkingValue,
        //   onChanged: (newValue) {
        //     setState(() {
        //       checkingValue = newValue;
        //     });
        //   },
        // ),
        );
  }

  Future<void> save() async {
    widget.todo.title = "titleField.text";
    testtitle.text = titleField.text;
    widget.todo.value = false;
    await dataBase_todo().add(widget.todo);
    refresh();
  }

  Future<void> refresh() async {
    todos = await dataBase_todo().getToDos();
    setState(() => loading = false);
  }
}
