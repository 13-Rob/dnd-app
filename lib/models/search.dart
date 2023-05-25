// To parse this JSON data, do
//
//     final searchResults = searchResultsFromJson(jsonString);

import 'dart:convert';

import 'package:proyecto_final/models/monster_info.dart';

SearchResults searchResultsFromJson(String str) =>
    SearchResults.fromJson(json.decode(str));

String searchResultsToJson(SearchResults data) => json.encode(data.toJson());

class SearchResults {
  int? count;
  dynamic next;
  dynamic previous;
  List<MonsterInfo> results;

  SearchResults({
    this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] != null
            ? List<MonsterInfo>.from(
                json["results"].map((x) => MonsterInfo.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

enum Subtype { EMPTY, DEVIL }

final subtypeValues = EnumValues({"devil": Subtype.DEVIL, "": Subtype.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
