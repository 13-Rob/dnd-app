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
    final jsonData = await _getJsonData('monsters/', term, cr);
    final monsterResponse = SearchResults.fromJson(json.decode(jsonData));
    monsterList = monsterResponse.results;
  }

  Future<MonsterInfo> getMonsterByName({required String name}) async {
    final jsonData = await _getJsonData('monsters/', name, '');
    final monsterResponse = SearchResults.fromJson(json.decode(jsonData));
    return monsterResponse.results.first;
  }

  Future<List<MonsterInfo>> getAllMonsterByCR([String cr = '']) async {
    List<String> crEspeciales = ["1/8", "1/4", "1/2"];
    if (crEspeciales.contains(cr)) {
      switch (cr) {
        case "1/8":
          cr = "0.125";
          break;

        case "1/4":
          cr = "0.25";
          break;

        case "1/2":
          cr = "0.5";
          break;
      }
    }

    final jsonData = await _getJsonData('monsters/', '', cr);
    final monsterResponse = SearchResults.fromJson(json.decode(jsonData));
    return monsterResponse.results;
  }
}
