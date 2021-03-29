import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DailyTrackerDatabase {
  static final _dbName = 'dailyTracker.db';
  static final _dbVersion = 1;

  DailyTrackerDatabase._databaseConstructor();

  static final DailyTrackerDatabase instance =
      DailyTrackerDatabase._databaseConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();

    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "daily_tracker.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    return db.execute('''
          CREATE TABLE project(projectNum INTEGER, projectName TEXT)
      ''');
  }
}
