import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/results.dart';
import 'package:proyecto_final/models/monster_details.dart';

class MonsterProvider extends ChangeNotifier {
  final String _baseUrl = 'www.dnd5eapi.co';
  List<Result> monsterList = [];
  List<String> challenge_rating = [];

  Future<String> _getJsonData(String endpoint) async {
    var url = Uri.https(_baseUrl, endpoint);

    var response = await http.get(url);

    return response.body;
  }

  // Future<List<Result>> getMonsters() async {
  //   final jsonData = await _getJsonData('api/monsters');
  //   final monstersResponse = Results.fromJson(json.decode(jsonData));

  //   if (monsterList.isEmpty) monsterList = [...monstersResponse.results];
  //   return monsterList;
  // }

  Future<MonsterDetails> getMonsterDetails(String monster) async {
    final jsonData = await _getJsonData('api/monsters/$monster');
    final monsterResponse = MonsterDetails.fromJson(json.decode(jsonData));

    return monsterResponse;
  }

  Result? getMonsterDetailsFromName(String name) {
    for (Result e in monsterList) {
      if (e.name == name) {
        return e;
      }
    }
    return null;
  }
}
