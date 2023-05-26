import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_final/models/favorite.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  get database async {
    if (_database != null) return _database;
    _database = await initDB();
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'TableFavorites.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE TableFavorites (
          id INTEGER PRIMARY KEY,
          slug TEXT,
          name TEXT,
          hp INTEGER,
          type TEXT,
          size TEXT
        )
        ''');
      },
    );
  }

  newFavorite(FavoriteModel monster) async {
    final Database db = await database;
    final id = await db.insert('TableFavorites', monster.toJson());
    return id;
  }

  Future<List<FavoriteModel>?> getFavorites() async {
    final Database db = await database;
    final res = await db.query('TableFavorites');
    if (res.isEmpty) {
      return null;
    }

    return res.map((e) => FavoriteModel.fromJson(e)).toList();
  }

  Future<int> deleteFav(int id) async {
    final Database db = await database;
    return await db.delete('TableFavorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteFavByName(String name) async {
    final Database db = await database;
    return await db
        .delete('TableFavorites', where: 'name = ?', whereArgs: [name]);
  }

  Future<int> deleteAllFavs() async {
    final Database db = await database;
    return await db.delete('TableFavorites');
  }
}
