import 'dart:async';
import 'dart:io';
import 'package:alisveris/Models/Favorite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteHelper{
  static final _databaseName = "alisveris.db";
  static final _databaseVersion = 1;
  static final favoriteTable = 'favorites';

  SQLiteHelper._privateConstructor();
  static final SQLiteHelper instance = SQLiteHelper._privateConstructor();

  static late Database _database;
  Future<Database> get database async {

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${favoriteTable} (
            id INTEGER PRIMARY KEY, productId INTEGER
           )
          ''');
  }

  Future<List<Favorite>> getFavorites() async{
    var result = await _database.query("favorites", orderBy: "id");
    return result.map((data) => Favorite.fromMap(data)).toList();
  }

  Future<int> insertItem(dynamic model, String tableName) async{
    return await _database.insert("$tableName", model.toMap());
  }

  Future<int> removeItem(String tableName, String columnName, int id) async{
    return await _database.delete("$tableName", where: "$columnName=?", whereArgs: [id]);
  }

}