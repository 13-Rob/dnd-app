// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  int? id;
  String slug;
  String name;
  String hp;
  String type;
  String size;

  FavoriteModel({
    this.id,
    required this.slug,
    required this.name,
    required this.hp,
    required this.type,
    required this.size,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        hp: json["hp"].toString(),
        type: json["type"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "hp": hp,
        "type": type,
        "size": size,
      };
}
