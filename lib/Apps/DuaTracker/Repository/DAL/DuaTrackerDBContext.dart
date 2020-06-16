import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DuaTrackerDBContext {
  static String dbName = 'dua_tracker.db';
  static int version = 1;

  static String duaTableCreateQuery = 'CREATE TABLE dua(id INTEGER PRIMARY KEY, name TEXT)';

  static String zikirTableCreateQuery = 'CREATE TABLE zikir(id INTEGER PRIMARY KEY, name TEXT, timesToBeRead INT, timesRead INT, duaID INT)';


  Future<Database> initializeDatabase() async {
    final database = openDatabase(join(await getDatabasesPath(), dbName),
        onCreate: (db, version) {
          db.execute(duaTableCreateQuery);
          db.execute(zikirTableCreateQuery);
        },
        version: version);

    return database;
  }
}
