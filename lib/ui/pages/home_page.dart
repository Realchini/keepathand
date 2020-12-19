import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_at_hand/models/note_model.dart';
import 'package:keep_at_hand/resources/app_strings.dart';
import 'package:keep_at_hand/service/db.dart';
import 'package:keep_at_hand/ui/pages/note_page.dart';
import 'package:keep_at_hand/ui/views/loading.dart';

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
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

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

      body: loading
          ? Loading()
          : Column(
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    AppStrings.title,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(5),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      Note note = notes[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white, //Colors.yellow[200]
                        child: Container(
                          //padding: EdgeInsets.all(0),
                          child: ListTile(
                            title: Text(
                              note.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              note.content,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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

                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> refresh() async {
    notes = await dataBase().getNotes();
    setState(() => loading = false);
  }

// void refresh() {
//   notes = dataBase().getNotes();
//   //setState(() => loading = false);
// }
}
