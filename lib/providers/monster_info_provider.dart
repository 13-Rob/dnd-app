import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/monster_info.dart';
import 'package:proyecto_final/models/search.dart';

class MonsterInfoProvider extends ChangeNotifier {
  final String _baseUrl = 'api.open5e.com';
  List<MonsterInfo> monsterList = [];

  Future<String> _getJsonData(String endpoint,
      [String term = '', String cr = '']) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'search': term,
      'cr': cr,
    });

    var response = await http.get(url);

    return response.body;
  }

  Future<MonsterInfo> getMonsterDetails(String monster) async {
    final jsonData = await _getJsonData('monsters/$monster');
    final monsterResponse = MonsterInfo.fromJson(json.decode(jsonData));

    return monsterResponse;
  }

  getMonsters(String term) async {
    final jsonData = await _getJsonData('monsters/', term);
    final monsterResponse = SearchResults.fromJson(json.decode(jsonData));
    monsterList = monsterResponse.results;
  }

  getMonsterByCR([String term = '', String cr = '']) async {
    // cr = 0;
    // print(cr);
    final jsonData = await _getJsonData('monsters/', term, cr);
    final monsterResponse = SearchResults.fromJson(json.decode(jsonData));
    // print(monsterResponse.results);
    // print(jsonData);
    monsterList = monsterResponse.results;
  }

  Future<List<MonsterInfo>> getAllMonsterByCR([String cr = '']) async {
    // cr = 0;
    // print(cr);
    final jsonData = await _getJsonData('monsters/', '', cr);
    final monsterResponse = SearchResults.fromJson(json.decode(jsonData));
    // print(monsterResponse.results);
    // print(jsonData);
    return monsterResponse.results;
  }
}
