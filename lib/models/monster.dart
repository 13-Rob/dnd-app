// To parse this JSON data, do
//
//     final monstersResult = monstersResultFromJson(jsonString);

import 'dart:convert';

MonstersResult monstersResultFromJson(String str) =>
    MonstersResult.fromJson(json.decode(str));

String monstersResultToJson(MonstersResult data) => json.encode(data.toJson());

class MonstersResult {
  int count;
  List<Result> results;

  MonstersResult({
    required this.count,
    required this.results,
  });

  factory MonstersResult.fromJson(Map<String, dynamic> json) => MonstersResult(
        count: json["count"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String index;
  String name;
  String url;

  Result({
    required this.index,
    required this.name,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        index: json["index"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "name": name,
        "url": url,
      };
}
