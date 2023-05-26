// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  int? id;
  String slug;

  FavoriteModel({
    this.id,
    required this.slug,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        slug: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": slug,
      };
}
