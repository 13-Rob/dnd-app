// To parse this JSON data, do
//
//     final monsterDetails = monsterDetailsFromJson(jsonString);

import 'dart:convert';

MonsterDetails monsterDetailsFromJson(String str) =>
    MonsterDetails.fromJson(json.decode(str));

String monsterDetailsToJson(MonsterDetails data) => json.encode(data.toJson());

class MonsterDetails {
  String index;
  String name;
  String size;
  String type;
  String alignment;
  List<ArmorClass> armorClass;
  int hitPoints;
  String hitDice;
  String hitPointsRoll;
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;
  List<ProficiencyElement> proficiencies;
  List<dynamic> damageVulnerabilities;
  List<dynamic> damageResistances;
  List<dynamic> damageImmunities;
  List<dynamic> conditionImmunities;
  String languages;
  double challengeRating;
  int xp;
  String? image;
  String url;

  MonsterDetails({
    required this.index,
    required this.name,
    required this.size,
    required this.type,
    required this.alignment,
    required this.armorClass,
    required this.hitPoints,
    required this.hitDice,
    required this.hitPointsRoll,
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
    required this.proficiencies,
    required this.damageVulnerabilities,
    required this.damageResistances,
    required this.damageImmunities,
    required this.conditionImmunities,
    required this.languages,
    required this.challengeRating,
    required this.xp,
    this.image,
    required this.url,
  });

  factory MonsterDetails.fromJson(Map<String, dynamic> json) => MonsterDetails(
        index: json["index"],
        name: json["name"],
        size: json["size"],
        type: json["type"],
        alignment: json["alignment"],
        armorClass: List<ArmorClass>.from(
            json["armor_class"].map((x) => ArmorClass.fromJson(x))),
        hitPoints: json["hit_points"],
        hitDice: json["hit_dice"],
        hitPointsRoll: json["hit_points_roll"],
        strength: json["strength"],
        dexterity: json["dexterity"],
        constitution: json["constitution"],
        intelligence: json["intelligence"],
        wisdom: json["wisdom"],
        charisma: json["charisma"],
        proficiencies: List<ProficiencyElement>.from(
            json["proficiencies"].map((x) => ProficiencyElement.fromJson(x))),
        damageVulnerabilities:
            List<dynamic>.from(json["damage_vulnerabilities"].map((x) => x)),
        damageResistances:
            List<dynamic>.from(json["damage_resistances"].map((x) => x)),
        damageImmunities:
            List<dynamic>.from(json["damage_immunities"].map((x) => x)),
        conditionImmunities:
            List<dynamic>.from(json["condition_immunities"].map((x) => x)),
        languages: json["languages"],
        challengeRating: json["challenge_rating"]?.toDouble(),
        xp: json["xp"],
        image: json["image"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "name": name,
        "size": size,
        "type": type,
        "alignment": alignment,
        "armor_class": List<dynamic>.from(armorClass.map((x) => x.toJson())),
        "hit_points": hitPoints,
        "hit_dice": hitDice,
        "hit_points_roll": hitPointsRoll,
        "strength": strength,
        "dexterity": dexterity,
        "constitution": constitution,
        "intelligence": intelligence,
        "wisdom": wisdom,
        "charisma": charisma,
        "proficiencies":
            List<dynamic>.from(proficiencies.map((x) => x.toJson())),
        "damage_vulnerabilities":
            List<dynamic>.from(damageVulnerabilities.map((x) => x)),
        "damage_resistances":
            List<dynamic>.from(damageResistances.map((x) => x)),
        "damage_immunities": List<dynamic>.from(damageImmunities.map((x) => x)),
        "condition_immunities":
            List<dynamic>.from(conditionImmunities.map((x) => x)),
        "languages": languages,
        "challenge_rating": challengeRating,
        "xp": xp,
        "image": image,
        "url": url,
      };
}

class ArmorClass {
  String type;
  int value;

  ArmorClass({
    required this.type,
    required this.value,
  });

  factory ArmorClass.fromJson(Map<String, dynamic> json) => ArmorClass(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}

class ProficiencyElement {
  int value;
  ProficiencyProficiency proficiency;

  ProficiencyElement({
    required this.value,
    required this.proficiency,
  });

  factory ProficiencyElement.fromJson(Map<String, dynamic> json) =>
      ProficiencyElement(
        value: json["value"],
        proficiency: ProficiencyProficiency.fromJson(json["proficiency"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "proficiency": proficiency.toJson(),
      };
}

class ProficiencyProficiency {
  String index;
  String name;
  String url;

  ProficiencyProficiency({
    required this.index,
    required this.name,
    required this.url,
  });

  factory ProficiencyProficiency.fromJson(Map<String, dynamic> json) =>
      ProficiencyProficiency(
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
