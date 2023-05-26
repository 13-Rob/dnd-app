import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:proyecto_final/models/favorite.dart';
import 'package:proyecto_final/providers/db_provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteModel> favorite = [];

  newFavorite(String slug) async {
    FavoriteModel fav = FavoriteModel(slug: slug);

    int id = await DBProvider.db.newFavorite(fav);
    // fav.id = id;
    // favorite.add(fav);
    // notifyListeners();
  }

  loadFavorites() async {
    // List<FavoriteModel>? favorites = await DBProvider.db.getFavorites();
  }
}
