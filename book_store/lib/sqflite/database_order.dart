import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBasePlaceOrder {
  static final _databasename = "updateDataBase.db";
  static final _databaseversion = 1;
  static final table = "orderbook_record";

  static final columnID = 'id';
  static final columnName = 'customername';
  static final columnLocality = 'locality';
  static final columnPincode = 'pincode';
  static final columnAddress = 'address';
  static final columnCity = 'city';
  static final columnLandmark = 'landmark';
  static final columnType = 'type';
  static final columnBookName = 'bookname';
  static final columnPrice = 'price';
  static final columnCheckUpdate = 'networkupdate';

  static Database? _database;

  DataBasePlaceOrder._privateConstructor();
  static final DataBasePlaceOrder instance =
      DataBasePlaceOrder._privateConstructor();

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
         $columnID TEXT,
         $columnName TEXT,
         $columnLocality TEXT,
         $columnPincode TEXT,
         $columnAddress TEXT,
         $columnCity TEXT,
         $columnLandmark TEXT,
         $columnType TEXT,
         $columnBookName TEXT,
         $columnPrice TEXT,
         $columnCheckUpdate TEXT
       )
      ''');
  }

  //Function for CRUD

  Future<int> insert(Map<String, dynamic> row) async {
    print('......................inside insert...............');
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<int> updateData(String network) async {
    Database? db = await instance.database;
    var result = await db!.update(table, {"networkupdate": "false"},
        where: "networkupdate=?", whereArgs: [network]);
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecific(String network) async {
    Database? db = await instance.database;
    var result =
        await db!.query(table, where: "networkupdate=?", whereArgs: [network]);
    return result;
  }
//   Future<List<Map<String, dynamic>>> queryall() async {
//     Database? db = await instance.database;
//     return await db!.query(table);
//   }

//   Future<List<Map<String, dynamic>>> querySpecific(String network) async {
//     Database? db = await instance.database;
//     var result =
//         await db!.query(table, where: "checkNetwork=?", whereArgs: [network]);
//     return result;
//   }

//   Future<int> deleteData() async {
//     Database? db = await instance.database;
//     var result = await db!.delete(table);
//     return result;
//   }

//   Future<int> updateData(String network) async {
//     Database? db = await instance.database;
//     var result = await db!.update(table, {"checkNetwork": "false"},
//         where: "checkNetwork=?", whereArgs: [network]);
//     return result;
//   }
}
