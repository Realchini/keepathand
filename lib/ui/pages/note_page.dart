import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_at_hand/models/note_model.dart';
import 'package:keep_at_hand/resources/app_colors.dart';
import 'package:keep_at_hand/resources/app_strings.dart';
import 'package:keep_at_hand/service/db.dart';
import 'package:keep_at_hand/ui/pages/home_page.dart';

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
    return WillPopScope(
      onWillPop: () {
        print("leaving note page");
        save();
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        /* appBar: AppBar(
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
        ), */
        body: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.appColor,
                    size: 32,
                  ),
                  onPressed: () {
                    print("leaving note page");
                    save();
                    Navigator.of(context).pop();
                  },
                  color: AppColors.appColor,
                ),
                Text(
                  editMode ? AppStrings.editMode : AppStrings.newNoteMode,
                  style: TextStyle(
                    color: AppColors.appColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(14),
                children: <Widget>[
                  _buildTitleField(),
                  SizedBox(height: 10),
                  _buildContentField(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTitleField() {
    return TextField(
      style: TextStyle(
        color: AppColors.editNoteTitleColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      controller: title,
      autofocus: true,
      decoration: InputDecoration(
          hintText: "Заголовок",
          hintStyle: TextStyle(color: AppColors.editNoteTitleHintColor)),
      textCapitalization: TextCapitalization.sentences,
    );
  }

  _buildContentField() {
    return TextField(
        controller: content,
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        //autofocus: true,
        maxLines: 22,
        style: TextStyle(color: AppColors.editNoteContentColor),
        decoration: InputDecoration(
            hintText: "Начните писать",
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppColors.editNoteContentHintColor)));
  }

  // _closePage() {
  //   print("leaving note page");
  //   save();
  //   Navigator.of(context).pop();
  // }

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
