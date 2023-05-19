// To parse this JSON data, do
//
//     final Results = ResultsFromJson(jsonString);

import 'dart:convert';

Results ResultsFromJson(String str) => Results.fromJson(json.decode(str));

String ResultsToJson(Results data) => json.encode(data.toJson());

class Results {
  int count;
  List<Result> results;

  Results({
    required this.count,
    required this.results,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
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
