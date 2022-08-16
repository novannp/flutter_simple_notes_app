import 'package:notes_app/models/note.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  //create getter the database
  Future<Database?> get database async {
    //check database available or not
    if (_database != null) {
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'note_app.db'),
      version: 1,
      onCreate: (db, version) async {
        //CREATE first table
        db.execute('''
        CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          body TEXT,
          creationDate DATE
        )
        ''');
      },
    );
  }

//add note to variable
  addNewNote(NoteModel note) async {
    final db = await database;

    db!.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //fetch database and return element inside note table
  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db!.query('notes');

    if (res.isEmpty) {
      return null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : null;
    }
  }

  //Edit Note
  Future<int> updateNote(NoteModel note) async {
    final db = await database;
    var result = await db!.rawUpdate('''
UPDATE notes SET title = "${note.title}" , body =  "${note.body}", creationDate = "${note.creationDate}" WHERE id = ${note.id}
''');
    return result;
  }

  // Delete Note
  Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await db!.rawDelete('DELETE FROM notes WHERE id = ?', [id]);
    return count;
  }
}
