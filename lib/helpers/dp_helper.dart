import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future datebase() async {
    final dpPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dpPath, 'places.db'),
        onCreate: (dp, version) {
      return dp.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image Text,price DOUBLE,loc_lat REAL,loc_lng REAL,address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sql.Database db = await DBHelper.datebase();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String,Object>>> getData(String table) async {
    final sql.Database db = await DBHelper.datebase();
   return db.query(table);
  }
}
