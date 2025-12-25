// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class NotesDatabase {
//   NotesDatabase._init();

//   static final NotesDatabase instance = NotesDatabase._init();
//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('notes.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }

//   Future<void> _createDB(Database db, int version) async {
//     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     const textType = 'TEXT NOT NULL';
//     const boolType = 'INTEGER NOT NULL';
//     const integerType = 'INTEGER NOT NULL';

//     await db.execute('''
//       CREATE TABLE notes (
//         id $idType,
//         title $textType,
//         content $textType,
//         isImportant $boolType,
//         createdTime $integerType
//       )
//     ''');
//   }

//   Future<int> addNote(String title, String content) async {
//     final db = await instance.database;

//     return await db.insert('notes', {
//       'title': title,
//       'content': content,
//       'isImportant': 0,
//       'createdTime': DateTime.now().millisecondsSinceEpoch,
//     });
//   }

//   Future<List<Map<String, dynamic>>> getNotes() async {
//     final db = await instance.database;
//     return await db.query(
//       'notes',
//       orderBy: 'createdTime DESC',
//     );
//   }

//   Future<int> updateNote(int id, String title, String content) async {
//     final db = await instance.database;

//     return await db.update(
//       'notes',
//       {
//         'title': title,
//         'content': content,
//         'isImportant': 0,
//         'createdTime': DateTime.now().millisecondsSinceEpoch,
//       },
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> deleteNote(int id) async {
//     final db = await instance.database;

//     return await db.delete(
//       'notes',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdTime INTEGER NOT NULL
      )
    ''');
  }

  Future<int> addNote(String title, String content) async {
    final db = await instance.database;
    return await db.insert('notes', {
      'title': title,
      'content': content,
      'createdTime': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await instance.database;
    return await db.query(
      'notes',
      orderBy: 'createdTime DESC',
    );
  }

  Future<int> updateNote(int id, String title, String content) async {
    final db = await instance.database;
    return await db.update(
      'notes',
      {
        'title': title,
        'content': content,
        'createdTime': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
