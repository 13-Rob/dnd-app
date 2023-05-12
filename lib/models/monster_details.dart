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
  Speed speed;
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
  Senses senses;
  String languages;
  double challengeRating;
  int xp;
  List<SpecialAbility>? specialAbilities;
  List<MonsterDetailsAction> actions;
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
    required this.speed,
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
    required this.senses,
    required this.languages,
    required this.challengeRating,
    required this.xp,
    this.specialAbilities,
    required this.actions,
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
        speed: Speed.fromJson(json["speed"]),
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
        senses: Senses.fromJson(json["senses"]),
        languages: json["languages"],
        challengeRating: json["challenge_rating"] + 0.0,
        xp: json["xp"],
        specialAbilities: List<SpecialAbility>.from(
            json["special_abilities"].map((x) => SpecialAbility.fromJson(x))),
        actions: List<MonsterDetailsAction>.from(
            json["actions"].map((x) => MonsterDetailsAction.fromJson(x))),
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
        "speed": speed.toJson(),
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
        "senses": senses.toJson(),
        "languages": languages,
        "challenge_rating": challengeRating,
        "xp": xp,
        "special_abilities":
            List<dynamic>.from(specialAbilities!.map((x) => x.toJson())),
        "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
        "image": image,
        "url": url,
      };
}

class MonsterDetailsAction {
  String name;
  String? multiattackType;
  String desc;
  List<ActionAction> actions;
  int? attackBonus;
  Dc? dc;
  List<Damage>? damage;
  Usage? usage;

  MonsterDetailsAction({
    required this.name,
    this.multiattackType,
    required this.desc,
    required this.actions,
    this.attackBonus,
    this.dc,
    this.damage,
    this.usage,
  });

  factory MonsterDetailsAction.fromJson(Map<String, dynamic> json) =>
      MonsterDetailsAction(
        name: json["name"],
        multiattackType: json["multiattack_type"],
        desc: json["desc"],
        actions: List<ActionAction>.from(
            json["actions"].map((x) => ActionAction.fromJson(x))),
        attackBonus: json["attack_bonus"],
        dc: json["dc"] == null ? null : Dc.fromJson(json["dc"]),
        damage: json["damage"] == null
            ? []
            : List<Damage>.from(json["damage"]!.map((x) => Damage.fromJson(x))),
        usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "multiattack_type": multiattackType,
        "desc": desc,
        "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
        "attack_bonus": attackBonus,
        "dc": dc?.toJson(),
        "damage": damage == null
            ? []
            : List<dynamic>.from(damage!.map((x) => x.toJson())),
        "usage": usage?.toJson(),
      };
}

class ActionAction {
  String actionName;
  int count;
  String type;

  ActionAction({
    required this.actionName,
    required this.count,
    required this.type,
  });

  factory ActionAction.fromJson(Map<String, dynamic> json) => ActionAction(
        actionName: json["action_name"],
        count: json["count"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "action_name": actionName,
        "count": count,
        "type": type,
      };
}

class Damage {
  DcTypeClass? damageType;
  String? damageDice;

  Damage({
    this.damageType,
    this.damageDice,
  });

  factory Damage.fromJson(Map<String, dynamic> json) {
    if (json["damage_type"] != null) {
      return Damage(
        damageType: DcTypeClass.fromJson(json["damage_type"]),
        damageDice: json["damage_dice"],
      );
    }
    return Damage();
  }

  Map<String, dynamic> toJson() => {
        "damage_type": damageType,
        "damage_dice": damageDice,
      };
}

class DcTypeClass {
  String index;
  String name;
  String url;

  DcTypeClass({
    required this.index,
    required this.name,
    required this.url,
  });

  factory DcTypeClass.fromJson(Map<String, dynamic> json) => DcTypeClass(
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

class Dc {
  DcTypeClass dcType;
  int dcValue;
  String successType;

  Dc({
    required this.dcType,
    required this.dcValue,
    required this.successType,
  });

  factory Dc.fromJson(Map<String, dynamic> json) => Dc(
        dcType: DcTypeClass.fromJson(json["dc_type"]),
        dcValue: json["dc_value"],
        successType: json["success_type"],
      );

  Map<String, dynamic> toJson() => {
        "dc_type": dcType.toJson(),
        "dc_value": dcValue,
        "success_type": successType,
      };
}

class Usage {
  String type;
  int? times;

  Usage({
    required this.type,
    this.times,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        type: json["type"],
        times: json["times"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "times": times,
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
  DcTypeClass proficiency;

  ProficiencyElement({
    required this.value,
    required this.proficiency,
  });

  factory ProficiencyElement.fromJson(Map<String, dynamic> json) =>
      ProficiencyElement(
        value: json["value"],
        proficiency: DcTypeClass.fromJson(json["proficiency"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "proficiency": proficiency.toJson(),
      };
}

class Senses {
  int passivePerception;
  String? blindsight;
  String? darkvision;
  String? tremorsense;
  String? truesight;

  Senses({
    required this.passivePerception,
    this.blindsight,
    this.darkvision,
    this.tremorsense,
    this.truesight,
  });

  factory Senses.fromJson(Map<String, dynamic> json) => Senses(
        passivePerception: json["passive_perception"],
        blindsight: json["blindsight"],
        darkvision: json["darkvision"],
        tremorsense: json["tremorsense"],
        truesight: json["truesight"],
      );

  Map<String, dynamic> toJson() => {
        "passive_perception": passivePerception,
        "blindsight": blindsight,
        "darkvision": darkvision,
        "tremorsense": tremorsense,
        "truesight": truesight,
      };
}

class SpecialAbility {
  String name;
  String desc;
  Dc? dc;

  SpecialAbility({
    required this.name,
    required this.desc,
    this.dc,
  });

  factory SpecialAbility.fromJson(Map<String, dynamic> json) => SpecialAbility(
        name: json["name"],
        desc: json["desc"],
        dc: json["dc"] == null ? null : Dc.fromJson(json["dc"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "dc": dc?.toJson(),
      };
}

class Speed {
  String? walk;
  String? burrow;
  String? climb;
  String? fly;
  String? swim;

  Speed({
    this.walk,
    this.burrow,
    this.climb,
    this.fly,
    this.swim,
  });

  factory Speed.fromJson(Map<String, dynamic> json) => Speed(
        walk: json["walk"],
        burrow: json["burrow"],
        climb: json["climb"],
        fly: json["fly"],
        swim: json["swim"],
      );

  Map<String, dynamic> toJson() => {
        "walk": walk,
        "burrow": burrow,
        "climb": climb,
        "fly": fly,
        "swim": swim,
      };
}
