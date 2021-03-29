import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DailyTrackerDatabase {
  static final _dbName = 'dailyTracker.db';
  static final _dbVersion = 1;
  static final tableName = {
    "project": "project",
    "currentProject": "currentProject",
    "projection": "projection",
    "issue": "issue",
  };

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
          CREATE TABLE $tableName["project"](projectNum INTEGER, projectName TEXT)
          CREATE TABLE $tableName["currentProject"](date TEXT PRIMARY KEY, projectTitle TEXT, projectUpdate TEXT)
          CREATE TABLE $tableName["projection"](date TEXT PRIMARY KEY, projectTitle TEXT, projectUpdate TEXT)
          CREATE TABLE $tableName["issue"](date TEXT PRIMARY KEY, slno INTEGER, issue TEXT, status TEXT)
      ''');
  }

  Future insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> select(String table) async {
    Database db = await instance.database;
    return db.query(table);
  }
}
