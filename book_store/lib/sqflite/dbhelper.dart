import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static final _databasename = "persons.db";
  static final _databaseversion = 1;
  static final table = "my_table";

  static final columnID = 'id';
  static final columnAuthor = 'author';
  static final columnImage = 'image';
  static final columnPrice = 'price';
  static final columnTitle = 'title';
  static final columnCheckNetwork = 'checkNetwork';

  static Database? _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

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
         $columnID INTEGER PRIMARY KEY,
         $columnAuthor TEXT,
         $columnImage TEXT,
         $columnPrice TEXT,
         $columnTitle TEXT,
         $columnCheckNetwork TEXT
       )
      ''');
  }

  //Function for CRUD

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    print('.................quert all ................');
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<List<Map<String, dynamic>>> querySpecific(String network) async {
    Database? db = await instance.database;
    var result =
        await db!.query(table, where: "checkNetwork=?", whereArgs: [network]);
    return result;
  }

  Future<List<Map<String, dynamic>>> checkBookPresentInTableOrNot(
      int bookId) async {
    Database? db = await instance.database;
    var result = await db!.query(table, where: "id=?", whereArgs: [bookId]);
    return result;
  }

/////////////////////////////////////////////////
  Future<int> deleteData(int id) async {
    Database? db = await instance.database;
    var result = await db!.delete(table, where: "id=?", whereArgs: [id]);
    return result;
  }

  Future<int> updateData(String network) async {
    Database? db = await instance.database;
    var result = await db!.update(table, {"checkNetwork": "false"},
        where: "checkNetwork=?", whereArgs: [network]);
    return result;
  }
}
