import 'dart:io';
import 'package:HaniNotes/Models/Note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return await openDatabase(join(documentsDirectory.path, "HaniNote.db"),
        onCreate: (db, version) async {
      await db.execute('''
                  CREATE TABLE notes(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  title TEXT,
                  content TEXT,
                  creationDate DATETIME
                  )
                  ''');
    }, version: 1);
  }

  addNewNote(Note note) async {
    final db = await database;
    db.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteNote(Note note) async {
    final db = await database;
    db.delete("notes",
        where: 'id = ?',
        whereArgs: [note.id]);
  }

  updateNote(Note note) async {
    final db = await database;
    db.update("notes", note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id]);
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query("notes");
    if (result.isEmpty) {
      return <Note>[];
    }
    return List.generate(result.length, (index) {
      int id = result[index]["id"];
      String title = result[index]["title"];
      String content = result[index]["content"];
      String creationDate = result[index]["creationDate"];
      if (creationDate.lastIndexOf("'")>=0) {
        creationDate=creationDate.substring(1,creationDate.lastIndexOf("'")-1);
      }

      return Note(
          id: id,
          title: title,
          content: content,
          creationDate: DateTime.parse(creationDate));
    });
    // //Falls mal alles gelöscht werden muss unteren Teil wieder einbauen
    // for (var element in test) {
    //   deleteNote(element);
    // }
    // return <Note>[];
  }
}
