import 'package:note_app/data/repositories/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDBProvider {
  final noteTableName = 'note_table';
  final idColumn = 'id';
  final titleColumn = 'title';
  final dateColumn = 'date';
  final noteColumn = 'note';
  final colorColumn = 'color';
  final tagColumn = 'tag';
  final reminderDateColumn = "reminder_date";
  final reminderStatusColumn = "reminder_status";

  // note_table
  // id  | title | date |  note  | color | tag
  //  ''      ''     ''      ''      ''     ''
  //  ''      ''     ''      ''      ''     ''

  // final reminderTableName = "reminder_table";
  // final noteIdColumn = "id";
  // final reminderDateColumn = "date";

  // reminder table
  // note_id | date |
  //    ''      ''

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
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $noteTableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $titleColumn TEXT, $dateColumn INTEGER, $noteColumn TEXT, $colorColumn TEXT, $tagColumn TEXT, $reminderDateColumn INTEGER, $reminderStatusColumn TEXT)',
    );

    // await db.execute(
    //   'CREATE TABLE $reminderTableName ($noteIdColumn INTEGER PRIMARY KEY, $reminderDateColumn INTEGER)',
    // );
  }

  // note queries
  Future<List<Note>> getAllNotes() async {
    Database db = await instance.db;
    List<Map<String, dynamic>> noteList = await db.query(noteTableName);
    return noteList.map((map) => Note.fromMap(map)).toList();
  }

  Future<Note> getNote(int id) async {
    Database db = await instance.db;
    List<Map<String, dynamic>> noteList = await db.query(noteTableName,
        where: '$idColumn = ?', whereArgs: [id], limit: 1);
    return Note.fromMap(noteList[0]);
  }

  Future<bool> addNote(Note note) async {
    Database db = await instance.db;
    final result = await db.insert(noteTableName, note.toMap());
    return result != 0 ? true : false;
  }

  Future<bool> updateNote(Note note) async {
    Database db = await instance.db;
    final result = await db.update(noteTableName, note.toMap(),
        where: '$idColumn = ?', whereArgs: [note.id]);
    return result > 0 ? true : false;
  }

  Future<bool> deleteNote(Note note) async {
    Database db = await instance.db;
    final result = await db
        .delete(noteTableName, where: '$idColumn = ?', whereArgs: [note.id]);
    return result > 0 ? true : false;
  }

  Future<bool> deleteAllNotes() async {
    Database db = await instance.db;
    final result = await db.delete(noteTableName);
    return result > 0 ? true : false;
  }

  // reminder queries
  // Future<Reminder> getReminder(int id) async {
  //   Database db = await instance.db;
  //   List<Map<String, dynamic>> result = await db.query(reminderTableName,
  //       where: '$noteIdColumn = ?', whereArgs: [id], limit: 1);
  //   return Reminder.fromMap(result[0]);
  // }

  // Future<bool> setReminder(Reminder reminder) async {
  //   Database db = await instance.db;
  //   final result = await db.insert(reminderTableName, reminder.toMap());
  //   return result > 0 ? true : false;
  // }

  // Future<bool> updateReminder(Reminder reminder) async {
  //   Database db = await instance.db;
  //   final result = await db.update(reminderTableName, reminder.toMap());
  //   return result > 0 ? true : false;
  // }

  // Future<bool> deleteReminder(int id) async {
  //   Database db = await instance.db;
  //   final result = await db
  //       .delete(reminderTableName, where: '$noteIdColumn = ?', whereArgs: [id]);
  //   return result > 0 ? true : false;
  // }
}
