import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/results.dart';

class ResultsProvider extends ChangeNotifier {
  final String _baseUrl = 'www.dnd5eapi.co';
  List<Result> monsterList = [];

  Future<String> _getJsonData(String endpoint) async {
    var url = Uri.https(_baseUrl, endpoint);

    var response = await http.get(url);

    return response.body;
  }

  Future<List<Result>> getResults(String endpoint) async {
    final jsonData = await _getJsonData('api/$endpoint');
    final monstersResponse = Results.fromJson(json.decode(jsonData));

    if (monsterList.isEmpty) monsterList = [...monstersResponse.results];
    return monsterList;
  }
}
