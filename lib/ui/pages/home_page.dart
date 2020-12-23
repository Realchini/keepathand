import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_at_hand/models/note_model.dart';
import 'package:keep_at_hand/models/preferences.dart';
import 'package:keep_at_hand/resources/app_colors.dart';
import 'package:keep_at_hand/resources/app_strings.dart';
import 'package:keep_at_hand/service/db.dart';
import 'package:keep_at_hand/ui/pages/note_page.dart';
import 'package:keep_at_hand/ui/pages/todo_page.dart';
import 'package:keep_at_hand/ui/views/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  List<Note> notes;

  //double statusBarHeight = MediaQuery.padding.top;

  @override
  void initState() {
    super.initState();
    Preferences();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,

      // appBar: AppBar(
      //   title: Text(
      //     "keep at hand",
      //     style: TextStyle(
      //         //fontStyle: FontStyle.italic,
      //         //fontWeight: FontWeight.bold,
      //         ),
      //   ),
      // ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotePage(note: new Note()))).then((v) {
            refresh();
          });
        },
      ),

      drawer: _buildDrawer(), // в общем-то можно удалить

      body: loading
          ? Loading()
          : Column(
              children: <Widget>[
                SizedBox(height: 40),
                Stack(
                  children: [
                    Align(child: _buildAppTitle(),),
                    Positioned(
                      right: 10,
                      top: 5,
                      child: _buildNightModeButton(),
                    )
                  ],
                ),
                Expanded(
                  child: (notes.length == 0)
                      ? _buildNoNotesText()
                      : ListView.builder(
                          padding: EdgeInsets.all(5),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            Note note = notes[index];
                            return _buildNoteCard(note);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  _buildAppTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        AppStrings.title,
        style: TextStyle(
          color: AppColors.appTitleColor,
          fontSize: 36,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  _buildNightModeButton() {
    return IconButton(
      //alignment: Alignment.centerRight,
      icon: Icon(
        Preferences.nightMode ? Icons.wb_sunny : Icons.nightlight_round,
        color: AppColors.cardSubtitleColor,
        size: 22,
      ),
      onPressed: () {setState(() {
        Preferences.setNightMode();
      });},
    );
  }

  _buildNoNotesText() {
    return Container(
        //alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Text(
          AppStrings.noNotes,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ));
  }

  _buildNoteCard(Note note) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.cardColor,
      child: Container(
        //padding: EdgeInsets.all(0),
        child: ListTile(
          title: Text(
            note.title,
            style: TextStyle(
              color: AppColors.cardTitleColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            note.content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.cardSubtitleColor,
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (_) => NotePage(
                          note: note,
                        )))
                .then((v) {
              refresh();
            });
          },
          onLongPress: () {
            //createAlertDialog(context, note);
            createAlertDialog(context, note).then((deleteOrNot) {
              if (deleteOrNot)
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(AppStrings.deleted),
                ));
            });
            print("long pressed on: " + note.title);
            //dataBase().delete(note);
            //refresh();
          },
        ),
      ),
    );
  }

  _buildDrawer() {
    return Drawer(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Добавить задачу (не работает)"),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ToDoPage()));
          },
        ),
      ],
    ));
  }

  Future<void> refresh() async {
    notes = await dataBase().getNotes();
    setState(() => loading = false);
  }

  Future<bool> createAlertDialog(BuildContext context, Note note) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.alertBackgroundColor,
            title: Text(AppStrings.deleteNoteQuestion),
            actions: [
              MaterialButton(
                elevation: 5.0,
                child: Text(AppStrings.yes),
                onPressed: () {
                  dataBase().delete(note);
                  refresh();
                  Navigator.of(context).pop(true);
                },
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text(AppStrings.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }

// void refresh() {
//   notes = dataBase().getNotes();
//   //setState(() => loading = false);
// }
}
