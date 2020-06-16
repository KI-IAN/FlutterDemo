import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaTrackerDBContext.dart';
import 'package:sqflite/sqflite.dart';

import 'Dua.dart';

class DuaRepository {
  String _tableName = 'dua';

  Future<int> insert(Dua dua) async {
    final Database db = await DuaTrackerDBContext().initializeDatabase();

    return await db.insert(_tableName, dua.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Dua>> duas() async {
    final Database db = await DuaTrackerDBContext().initializeDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (index) {
      return Dua(id: maps[index]['id'], name: maps[index]['name']);
    });
  }

  Future<int> update(Dua dua) async {
    final Database db = await DuaTrackerDBContext().initializeDatabase();
    return await db
        .update(_tableName, dua.toMap(), where: 'id = ?', whereArgs: [dua.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await DuaTrackerDBContext().initializeDatabase();
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
