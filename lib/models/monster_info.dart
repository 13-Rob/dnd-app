// To parse this JSON data, do
//
//     final monsterInfo = monsterInfoFromJson(jsonString);

import 'dart:convert';

MonsterInfo monsterInfoFromJson(String str) =>
    MonsterInfo.fromJson(json.decode(str));

String monsterInfoToJson(MonsterInfo data) => json.encode(data.toJson());

class MonsterInfo {
  String slug;
  String name;
  String size;
  String type;
  String subtype;
  String? group;
  String alignment;
  int armorClass;
  String armorDesc;
  int hitPoints;
  String hitDice;
  Speed speed;
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;
  int? strengthSave;
  int? dexteritySave;
  int? constitutionSave;
  int? intelligenceSave;
  int? wisdomSave;
  int? charismaSave;
  int perception;
  Skills skills;
  String damageVulnerabilities;
  String damageResistances;
  String damageImmunities;
  String conditionImmunities;
  String senses;
  String languages;
  String challengeRating;
  double? cr;
  List<Action> actions;
  String reactions;
  String legendaryDesc;
  List<LegendaryAction> legendaryActions;
  List<LegendaryAction> specialAbilities;
  List<dynamic> spellList;
  int pageNo;
  String imgMain;
  String documentSlug;
  String documentTitle;
  String documentLicenseUrl;
  String documentUrl;

  MonsterInfo({
    required this.slug,
    required this.name,
    required this.size,
    required this.type,
    required this.subtype,
    this.group,
    required this.alignment,
    required this.armorClass,
    required this.armorDesc,
    required this.hitPoints,
    required this.hitDice,
    required this.speed,
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
    this.strengthSave,
    this.dexteritySave,
    this.constitutionSave,
    this.intelligenceSave,
    this.wisdomSave,
    this.charismaSave,
    required this.perception,
    required this.skills,
    required this.damageVulnerabilities,
    required this.damageResistances,
    required this.damageImmunities,
    required this.conditionImmunities,
    required this.senses,
    required this.languages,
    required this.challengeRating,
    this.cr,
    required this.actions,
    required this.reactions,
    required this.legendaryDesc,
    required this.legendaryActions,
    required this.specialAbilities,
    required this.spellList,
    required this.pageNo,
    required this.imgMain,
    required this.documentSlug,
    required this.documentTitle,
    required this.documentLicenseUrl,
    required this.documentUrl,
  });

  factory MonsterInfo.fromJson(Map<String, dynamic> json) => MonsterInfo(
        slug: json["slug"],
        name: json["name"],
        size: json["size"],
        type: json["type"],
        subtype: json["subtype"],
        group: json["group"],
        alignment: json["alignment"],
        armorClass: json["armor_class"],
        armorDesc: json["armor_desc"],
        hitPoints: json["hit_points"],
        hitDice: json["hit_dice"],
        speed: Speed.fromJson(json["speed"]),
        strength: json["strength"],
        dexterity: json["dexterity"],
        constitution: json["constitution"],
        intelligence: json["intelligence"],
        wisdom: json["wisdom"],
        charisma: json["charisma"],
        strengthSave: json["strength_save"],
        dexteritySave: json["dexterity_save"],
        constitutionSave: json["constitution_save"],
        intelligenceSave: json["intelligence_save"],
        wisdomSave: json["wisdom_save"],
        charismaSave: json["charisma_save"],
        perception: json["perception"],
        skills: Skills.fromJson(json["skills"]),
        damageVulnerabilities: json["damage_vulnerabilities"],
        damageResistances: json["damage_resistances"],
        damageImmunities: json["damage_immunities"],
        conditionImmunities: json["condition_immunities"],
        senses: json["senses"],
        languages: json["languages"],
        challengeRating: json["challenge_rating"],
        cr: json["cr"],
        actions:
            List<Action>.from(json["actions"].map((x) => Action.fromJson(x))),
        reactions: json["reactions"],
        legendaryDesc: json["legendary_desc"],
        legendaryActions: List<LegendaryAction>.from(
            json["legendary_actions"].map((x) => LegendaryAction.fromJson(x))),
        specialAbilities: List<LegendaryAction>.from(
            json["special_abilities"].map((x) => LegendaryAction.fromJson(x))),
        spellList: List<dynamic>.from(json["spell_list"].map((x) => x)),
        pageNo: json["page_no"],
        imgMain: json["img_main"],
        documentSlug: json["document__slug"],
        documentTitle: json["document__title"],
        documentLicenseUrl: json["document__license_url"],
        documentUrl: json["document__url"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "size": size,
        "type": type,
        "subtype": subtype,
        "group": group,
        "alignment": alignment,
        "armor_class": armorClass,
        "armor_desc": armorDesc,
        "hit_points": hitPoints,
        "hit_dice": hitDice,
        "speed": speed.toJson(),
        "strength": strength,
        "dexterity": dexterity,
        "constitution": constitution,
        "intelligence": intelligence,
        "wisdom": wisdom,
        "charisma": charisma,
        "strength_save": strengthSave,
        "dexterity_save": dexteritySave,
        "constitution_save": constitutionSave,
        "intelligence_save": intelligenceSave,
        "wisdom_save": wisdomSave,
        "charisma_save": charismaSave,
        "perception": perception,
        "skills": skills.toJson(),
        "damage_vulnerabilities": damageVulnerabilities,
        "damage_resistances": damageResistances,
        "damage_immunities": damageImmunities,
        "condition_immunities": conditionImmunities,
        "senses": senses,
        "languages": languages,
        "challenge_rating": challengeRating,
        "cr": cr,
        "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
        "reactions": reactions,
        "legendary_desc": legendaryDesc,
        "legendary_actions":
            List<dynamic>.from(legendaryActions.map((x) => x.toJson())),
        "special_abilities":
            List<dynamic>.from(specialAbilities.map((x) => x.toJson())),
        "spell_list": List<dynamic>.from(spellList.map((x) => x)),
        "page_no": pageNo,
        "img_main": imgMain,
        "document__slug": documentSlug,
        "document__title": documentTitle,
        "document__license_url": documentLicenseUrl,
        "document__url": documentUrl,
      };
}

class Action {
  String name;
  String desc;
  int? attackBonus;
  String? damageDice;
  int? damageBonus;

  Action({
    required this.name,
    required this.desc,
    this.attackBonus,
    this.damageDice,
    this.damageBonus,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        name: json["name"],
        desc: json["desc"],
        attackBonus: json["attack_bonus"],
        damageDice: json["damage_dice"],
        damageBonus: json["damage_bonus"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "attack_bonus": attackBonus,
        "damage_dice": damageDice,
        "damage_bonus": damageBonus,
      };
}

class LegendaryAction {
  String name;
  String desc;

  LegendaryAction({
    required this.name,
    required this.desc,
  });

  factory LegendaryAction.fromJson(Map<String, dynamic> json) =>
      LegendaryAction(
        name: json["name"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
      };
}

class Skills {
  int history;
  int perception;

  Skills({
    required this.history,
    required this.perception,
  });

  factory Skills.fromJson(Map<String, dynamic> json) => Skills(
        history: json["history"],
        perception: json["perception"],
      );

  Map<String, dynamic> toJson() => {
        "history": history,
        "perception": perception,
      };
}

class Speed {
  int walk;
  int swim;

  Speed({
    required this.walk,
    required this.swim,
  });

  factory Speed.fromJson(Map<String, dynamic> json) => Speed(
        walk: json["walk"],
        swim: json["swim"],
      );

  Map<String, dynamic> toJson() => {
        "walk": walk,
        "swim": swim,
      };
}
