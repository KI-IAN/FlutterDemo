import 'dart:async';
import 'package:fluttertutorial/screen/SqfLite/Models/BaseModel.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      String _path = await getDatabasesPath() + 'example';
      await deleteDatabase(_path);
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'example';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE todo_items (id INTEGER PRIMARY KEY NOT NULL, task STRING, complete BOOLEAN)');

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db.query(table);

  static Future<int> insert(String table, BaseModel model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, BaseModel model) async => await _db
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, BaseModel model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);
}
