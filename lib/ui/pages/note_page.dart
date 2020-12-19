import 'package:flutter/material.dart';
import 'package:keep_at_hand/models/note_model.dart';
import 'package:keep_at_hand/resources/app_strings.dart';
import 'package:keep_at_hand/service/db.dart';

class NotePage extends StatefulWidget {
  final Note note;

  NotePage({this.note});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController title, content;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    title = new TextEditingController();
    content = new TextEditingController();
    if (widget.note.id != null) {
      editMode = true;
      title.text = widget.note.title;
      content.text = widget.note.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? AppStrings.editMode : AppStrings.newNoteMode),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              setState(() {});
              save();
              editMode = true;
            },
          ),
          if (editMode)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                delete();
              },
            )
        ],
      ),
      body: ListView(padding: EdgeInsets.all(14), children: <Widget>[
        TextField(
          controller: title,
          decoration: InputDecoration(hintText: "Заголовок"),
        ),
        SizedBox(height: 10),
        TextField(
            controller: content,
            keyboardType: TextInputType.multiline,
            autofocus: true,
            maxLines: 22,
            decoration: InputDecoration(hintText: "Начните писать", border: InputBorder.none,)),
      ]),
    );
  }

  Future<void> save() async {
    if (title.text != '') {
      widget.note.title = title.text;
      widget.note.content = content.text;
      if (editMode)
        await dataBase().update(widget.note);
      else
        await dataBase().add(widget.note);
    }
  }

  Future<void> delete() async {
    await dataBase().delete(widget.note);
    Navigator.pop(context);
  }
}
