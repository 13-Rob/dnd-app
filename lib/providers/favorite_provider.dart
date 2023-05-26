import 'package:flutter/material.dart';
import 'package:proyecto_final/models/favorite.dart';
import 'package:proyecto_final/models/monster_info.dart';
import 'package:proyecto_final/providers/db_provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteModel> favorite = [];

  newFavorite(MonsterInfo mon) async {
    FavoriteModel fav = FavoriteModel(
      slug: mon.slug,
      name: mon.name,
      hp: mon.hitPoints.toString(),
      type: mon.alignment,
      size: mon.size,
    );

    int id = await DBProvider.db.newFavorite(fav);
    fav.id = id;
    favorite.add(fav);
    notifyListeners();
  }

  loadFavorites() async {
    List<FavoriteModel>? favorites = await DBProvider.db.getFavorites();

    if (favorites != null) {
      favorite = [...favorites];
    } else {
      favorite = [];
    }

    notifyListeners();
  }

  eraseAll() async {
    await DBProvider.db.deleteAllFavs();
  }

  eraseFavByName(String name) async {
    await DBProvider.db.deleteFavByName(name);

    loadFavorites();
  }

  eraseFavByID(int id) async {
    await DBProvider.db.deleteFav(id);
    loadFavorites();
  }
}
