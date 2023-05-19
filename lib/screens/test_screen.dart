import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/monster_info.dart' as mon;
import 'package:proyecto_final/providers/monster_info_provider.dart';
import 'package:proyecto_final/widgets/custom_divider_widget.dart';
import 'package:proyecto_final/widgets/stats_widget.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final monsterInfo = Provider.of<MonsterInfoProvider>(context);
    String monster = 'aboleth';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monster'),
      ),
      body: FutureBuilder(
        future: monsterInfo.getMonsterDetails(monster),
        builder: (_, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                height: 180,
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          mon.MonsterInfo monsterData = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(monsterData.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      _MonsterHeader(monster: monsterData),
                      _DescriptionAndImage(monster: monsterData),
                      Stats(
                        strength: monsterData.strength,
                        dexterity: monsterData.dexterity,
                        constitution: monsterData.constitution,
                        intelligence: monsterData.intelligence,
                        wisdom: monsterData.wisdom,
                        charisma: monsterData.charisma,
                      ),
                      const CustomDivider(),
                      _Actions(actions: monsterData.actions),
                      if (monsterData.specialAbilities != null)
                        _NameAndDescList(
                            name: 'Special Abilities',
                            abilities: monsterData.specialAbilities!),
                      if (monsterData.legendaryActions != null)
                        _NameAndDescList(
                            name: 'Legendary Actions',
                            abilities: monsterData.legendaryActions!),
                      const CustomDivider()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MonsterHeader extends StatelessWidget {
  const _MonsterHeader({super.key, required this.monster});

  final mon.MonsterInfo monster;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 12, left: 40, right: 40),
      child: Column(
        children: [
          Text('Hit Points: ${monster.hitPoints} (${monster.hitDice})'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Armor Class: ${monster.armorClass}'),
              if (monster.speed.walk != null)
                Text('Speed: ${monster.speed.walk} ft.'),
            ],
          ),
        ],
      ),
    );
  }
}

class _NameAndDescList extends StatelessWidget {
  const _NameAndDescList(
      {super.key, required this.name, required this.abilities});

  final String name;
  final List<mon.LegendaryAction> abilities;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 40),
        title: Text(name),
        childrenPadding: const EdgeInsets.only(bottom: 8),
        children: abilities
            .map((e) => Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(e.name),
                ))
            .toList());
  }
}

class _Actions extends StatelessWidget {
  const _Actions({super.key, required this.actions});

  final List<mon.Action> actions;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 40),
      title: const Text('Actions'),
      childrenPadding: const EdgeInsets.only(bottom: 8),
      children: actions
          .map((e) => Padding(
                padding: const EdgeInsets.all(6),
                child: Text(e.name),
              ))
          .toList(),
    );
    // Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 4),
    //   child: Column(
    //     children: [
    //       const Padding(
    //         padding: EdgeInsets.only(bottom: 4.0),
    //         child: Text(
    //           'Actions:',
    //           style: TextStyle(fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       ...actions.map(
    //         (e) {
    //           return Padding(
    //             padding:
    //                 const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
    //             child: Center(
    //               child: RichText(
    //                 textAlign: TextAlign.justify,
    //                 text: TextSpan(
    //                   style: const TextStyle(color: Colors.black),
    //                   children: [
    //                     TextSpan(text: e.name),
    //                     if (e.damageDice != null)
    //                       TextSpan(text: ': ${e.damageDice}'),
    //                     if (e.damageBonus != null)
    //                       TextSpan(text: '+${e.damageBonus}')
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           );
    //   },
    // ).toList(),
    // ],
    // ),
  }
}

class _DescriptionAndImage extends StatelessWidget {
  const _DescriptionAndImage({
    super.key,
    required this.monster,
  });

  final mon.MonsterInfo monster;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomDivider(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(
              monster.imgMain ??
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png',
            ),
            fit: BoxFit.cover,
            height: 250,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            '${monster.size} ${monster.type}, ${monster.alignment}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const CustomDivider(),
      ],
    );
  }
}
