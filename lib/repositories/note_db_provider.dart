import 'package:note_app/repositories/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDBProvider {
  final tableName = 'note_table';
  final idColumn = 'id';
  final titleColumn = 'title';
  final dateColumn = 'date';
  final noteColumn = 'note';

  // note_table
  // _id  | title | date |  note  |
  //  ''      ''     ''      ''
  //  ''      ''     ''      ''

  static final NoteDBProvider instance = NoteDBProvider._instance();
  NoteDBProvider._instance();
  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB('simple_note.db');
    return _db!;
  }

  Future<Database> initDB(String filePath) async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, filePath);
    return await openDatabase(path, version: 2, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $titleColumn TEXT, $dateColumn TEXT, $noteColumn TEXT)');
  }

  Future<List<Note>> getAllNotes() async {
    Database db = await instance.db;
    List<Map<String, dynamic>> noteList = await db.query(tableName);
    return noteList.map((map) => Note.fromMap(map)).toList();
  }

  Future<Note> getNote(int id) async {
    Database db = await instance.db;
    List<Map<String, dynamic>> noteList = await db.query(tableName,
        where: '$idColumn = ?', whereArgs: [id], limit: 1);
    return Note.fromMap(noteList[0]);
  }

  Future<bool> addNote(Note note) async {
    Database db = await instance.db;
    final result = await db.insert(tableName, note.toMap());
    return result != 0 ? true : false;
  }

  Future<bool> updateNote(Note note) async {
    Database db = await instance.db;
    final result = await db.update(tableName, note.toMap(),
        where: '$idColumn = ?', whereArgs: [note.id]);
    return result > 0 ? true : false;
  }

  Future<bool> deleteNote(Note note) async {
    Database db = await instance.db;
    final result = await db
        .delete(tableName, where: '$idColumn = ?', whereArgs: [note.id]);
    return result > 0 ? true : false;
  }

  Future<bool> deleteAllNotes() async {
    Database db = await instance.db;
    final result = await db.delete(tableName);
    return result > 0 ? true : false;
  }
}
