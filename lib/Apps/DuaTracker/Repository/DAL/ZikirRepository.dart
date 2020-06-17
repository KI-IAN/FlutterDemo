import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaTrackerDBContext.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/Zikir.dart';
import 'package:sqflite/sqflite.dart';

class ZikirRepository{

  String _tableName = 'zikir';

  Future<int> insert(Zikir zikir) async {
    final Database db = await DuaTrackerDBContext().initializeDatabase();

    return await db.insert(_tableName, zikir.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Zikir>> zikirs(int duaID) async {
    final Database db = await DuaTrackerDBContext().initializeDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_tableName, where: 'duaID = ?', whereArgs: [duaID]);

    return List.generate(maps.length, (index) {
      return Zikir(id: maps[index]['id'], name: maps[index]['name']);
    });
  }

  Future<int> update(Zikir zikir) async {
    final Database db = await DuaTrackerDBContext().initializeDatabase();
    return await db
        .update(_tableName, zikir.toMap(), where: 'id = ?', whereArgs: [zikir.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await DuaTrackerDBContext().initializeDatabase();
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }


}