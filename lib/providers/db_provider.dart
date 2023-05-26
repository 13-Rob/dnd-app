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
    String path = join(documentDirectory.path, 'FavoritesDB.db');

    print('DB Path $path');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE Favorite (
          id INTEGER PRIMARY KEY,
          slug TEXT
        )
        ''');
    });
  }

  newFavorite(FavoriteModel monster) async {
    final Database db = await database;
    // final Database db = await database;

    final id = await db.insert('FavoriteMons', monster.toJson());
    return id;
  }
}
