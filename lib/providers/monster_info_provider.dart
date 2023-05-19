import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/monster_info.dart';
import 'package:proyecto_final/models/results.dart';

class MonsterInfoProvider extends ChangeNotifier {
  final String _baseUrl = 'api.open5e.com';
  List<Result> monsterList = [];
  List<String> challenge_rating = [];

  Future<String> _getJsonData(String endpoint) async {
    var url = Uri.https(_baseUrl, endpoint);

    var response = await http.get(url);

    return response.body;
  }

  Future<MonsterInfo> getMonsterDetails(String monster) async {
    final jsonData = await _getJsonData('monsters/$monster');
    final monsterResponse = MonsterInfo.fromJson(json.decode(jsonData));

    return monsterResponse;
  }
}
