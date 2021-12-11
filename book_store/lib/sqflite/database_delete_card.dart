import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseDeleteCardItem {
  static final _databasename = "deleteCard.db";
  static final _databaseversion = 1;
  static final table = "delete_card_item";

  static final columnID = 'id';

  static Database? _database;

  DataBaseDeleteCardItem._privateConstructor();
  static final DataBaseDeleteCardItem instance =
      DataBaseDeleteCardItem._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _oncreate);
  }

  _oncreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table(
         $columnID TEXT
       )
      ''');
  }

  //Function for CRUD

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<List<Map<String, dynamic>>> querySpecific(String network) async {
    Database? db = await instance.database;
    var result =
        await db!.query(table, where: "checkNetwork=?", whereArgs: [network]);
    return result;
  }

  Future<int> deleteData() async {
    Database? db = await instance.database;
    var result = await db!.delete(table);
    return result;
  }

  Future<int> updateData(String network) async {
    Database? db = await instance.database;
    var result = await db!.update(table, {"checkNetwork": "false"},
        where: "checkNetwork=?", whereArgs: [network]);
    return result;
  }
}
