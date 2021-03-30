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
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  //Future _onCreate(Database db, int version) {
  void _onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE ${tableName["projection"]}(date TEXT PRIMARY KEY, projectTitle TEXT, projectUpdate TEXT)      
      ''');

    db.execute('''
    CREATE TABLE ${tableName["issue"]}(date TEXT PRIMARY KEY, slno INTEGER, issue TEXT, status TEXT)      
      ''');

    db.execute('''
          CREATE TABLE ${tableName["project"]}(projectNum INTEGER, projectName TEXT)
      ''');

    db.execute('''
          CREATE TABLE ${tableName["currentProject"]}(date TEXT PRIMARY KEY, projectTitle TEXT, projectUpdate TEXT)
      ''');
  }

  Future insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    /*
    String date = row['date'];
    /*
    To get all the dates in a particular table
    List<Map<String, dynamic>> currentRow = await db.query(table, columns: ['date']);
    print(currentRow);
     */

    List dateList = await db.query(table, where: 'date = ?', whereArgs: [date]);
    if (dateList.length > 0) {
      return update(table, row);
    }
    */
    bool search = await searchQuery(table, row['date']);
    if (search) {
      return await update(table, row);
    }
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> select(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  //Todo delete
  Future<List<Map<String, dynamic>>> selectByDate(
      String table, String date) async {
    Database db = await instance.database;
    return await db.query(table, where: 'date = ?', whereArgs: [date]);
  }

  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    String date = row['date'];
    return await db.update(table, row, where: 'date = ?', whereArgs: [date]);
  }

  Future<bool> searchQuery(
    String table,
    String date,
    /*Map<String, dynamic> row*/
  ) async {
    Database db = await instance.database;
    //String date = row['date'];
    List dateList = await db.query(table, where: 'date = ?', whereArgs: [date]);
    if (dateList.length > 0) {
      return true;
    } else {
      return false;
    }
  }
}
