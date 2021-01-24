import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> getDB() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), "langs1.db"),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE lang_table(en TEXT PRIMARY KEY, zh TEXT, hi TEXT,es TEXT, fr TEXT)");
      },
      version: 1,
    );
    return database;
  }

  static Future<bool> getDBExists() async {
    return await databaseExists(
        path.join(await getDatabasesPath(), "langs1.db"));
  }
}
