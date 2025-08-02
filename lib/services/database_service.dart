import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class FlightCacheDb {
  static final FlightCacheDb _instance = FlightCacheDb._internal();
  factory FlightCacheDb() => _instance;
  FlightCacheDb._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  Future<Database> _init() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'flight_cache.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE FlightCache (
            id INTEGER PRIMARY KEY,
            payload TEXT NOT NULL,
            updatedAt INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> upsertPayload(String jsonPayload) async {
    final database = await db;
    final now = DateTime.now().millisecondsSinceEpoch;
    await database.insert(
      'FlightCache',
      {
        'id': 1,
        'payload': jsonPayload,
        'updatedAt': now,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getCachedPayload() async {
    final database = await db;
    final maps = await database.query(
      'FlightCache',
      where: 'id = ?',
      whereArgs: [1],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return maps.first['payload'] as String;
  }

  Future<int?> getCacheTimestamp() async {
    final database = await db;
    final maps = await database.query(
      'FlightCache',
      columns: ['updatedAt'],
      where: 'id = ?',
      whereArgs: [1],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return maps.first['updatedAt'] as int;
  }
}
