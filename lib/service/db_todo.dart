import 'package:keep_at_hand/models/note_model.dart';
import 'package:keep_at_hand/models/todo_list_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dataBase_todo {
  static Database _database;
  final String table = 'todo';

  Future<Database> get db async {
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var dir = await getDatabasesPath();
    String path = join(dir, 'todo.db');
    var database = await openDatabase(
      path,
      version: 2,
      onCreate: (Database _db, int version) async {
        await _db.execute(
          'CREATE TABLE $table(id INTEGER PRIMARY KEY AUTOINCREMENT, date INTEGER, title TEXT, value INTEGER)'
        );
    }
    );
    return database;
  }

  Future<void> add(ToDo todo) async {
    var database = await db;
    todo.setDate();
    await database.insert(table, todo.toMap());
  }

  Future<void> update(ToDo todo) async {
    var database = await db;
    todo.setDate();
    await database.update(table, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> delete(ToDo todo) async {
    var database = await db;
    await database.delete(table, where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<List<ToDo>> getToDos() async {
    var database = await db;
    List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM $table ORDER BY date DESC');
    List<ToDo> todos = new List<ToDo>();
    for(Map<String, dynamic> map in maps) {
      todos.add(ToDo.fromMap(map));
    }
    return todos;
  }
}