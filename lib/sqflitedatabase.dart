import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static const _databaseName = 'imeiTracker.db';
  Database? _database;

  Future<Database?> get DatabaseHandler async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE INFORMATION(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,price TEXT NOT NULL,quantity TEXT NOT NULL,mdate TEXT NOT NULL,exdate TEXT NOT NULL,purchasedate TEXT NOT NULL)''',
    );
  }

  Future<dynamic> firstnamesend(String Name, String Price, String Quantity,
      String Mdate, String Exdate, String Purchasedate) async {
    Database? db = await instance.DatabaseHandler;
    var insert = await db!.insert("INFORMATION", {
      'name': Name,
      'price': Price,
      'quantity': Quantity,
      'mdate': Mdate,
      'exdate': Exdate,
      'purchasedate': Purchasedate,
    });
    return insert;
  }

  Future<dynamic> select() async {
    Database? db = await instance.DatabaseHandler;
    var select = await db!.query('INFORMATION');
    return select;
  }

  void initWinDB() {}
}
