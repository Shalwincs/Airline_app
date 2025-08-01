import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseService {
  static Database? _db;

  /// Cached values to avoid repeated DB hits.
  static bool alreadyLoggedIn = false;
  static String? userId;

  /// Initialize DB and load existing login data.
  static Future<void> init() async {
    if (_db != null) return;

    // Get path to store the database.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'local_service.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE login_info (
            id INTEGER PRIMARY KEY,
            userId TEXT,
            isLoggedIn INTEGER
          )
        ''');
        // Insert initial empty row to simplify updates
        await db.insert('login_info', {
          'id': 1,
          'userId': null,
          'isLoggedIn': 0,
        });
      },
    );

    await getLoginData();
  }

  /// Set login data (marks logged in and stores userId).
  static Future<void> setLoginData({required String kuserId}) async {
    if (_db == null) await init();

    userId = kuserId;
    alreadyLoggedIn = true;

    await _db!.insert(
      'login_info',
      {
        'id': 1,
        'userId': kuserId,
        'isLoggedIn': 1,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieve login data from SQLite.
  static Future<void> getLoginData() async {
    if (_db == null) await init();

    final maps = await _db!.query(
      'login_info',
      where: 'id = ?',
      whereArgs: [1],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      final row = maps.first;
      alreadyLoggedIn = (row['isLoggedIn'] as int) == 1;
      userId = row['userId'] as String?;
    } else {
      alreadyLoggedIn = false;
      userId = null;
    }
  }

  /// Remove login data (log out).
  static Future<void> removeLoggingData() async {
    if (_db == null) await init();

    alreadyLoggedIn = false;
    userId = null;

    await _db!.update(
      'login_info',
      {
        'userId': null,
        'isLoggedIn': 0,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  /// Optional: close DB if needed.
  static Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
