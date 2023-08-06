import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class FavoritePlaceApi {
  static String get dataBaseName => 'Places';
  static sql.Database? _dataBase;

  static Future<sql.Database> get dataBase async {
    final dbPath = await sql.getDatabasesPath();    
    if (_dataBase == null) {
      _dataBase = await sql.openDatabase(
        path.join(dbPath, '$dataBaseName.db'),
        version: 1,
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE Places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
        },
      );

      return _dataBase!;
    }
    else{
      return _dataBase!;
    }
  }
  
  static insert(Map<String, Object?> map) async {    
    (await dataBase).insert(dataBaseName, map);
  }

  static deleteById(String id)
  async {
    (await dataBase).delete(dataBaseName, where: 'id = ?', whereArgs: [id]);    
  }
  
}
