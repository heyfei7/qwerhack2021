import "dbUtils.dart";
import "package:sqflite/sqflite.dart";

class LangModel {
  static Future<Map<String, dynamic>> getLangList() async {
    final db = await DBUtils.getDB();

    List<Map<String, dynamic>> langList = await db.query("lang_table");
    if (langList.length == 0) return Map<String, dynamic>();

    return langList[0];
  }

  static Future<void> insertLangList(Map<String, String> langList) async {
    final db = await DBUtils.getDB();

    await db.insert("lang_table", langList,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
