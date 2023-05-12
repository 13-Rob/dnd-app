import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/monster.dart';
import 'package:proyecto_final/models/monster_details.dart';
import 'package:proyecto_final/providers/monster_provider.dart';
import 'package:proyecto_final/widgets/custom_divider_widget.dart';
import 'package:proyecto_final/widgets/stats_widget.dart';

class MonsterScreen extends StatelessWidget {
  const MonsterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Result monster = ModalRoute.of(context)?.settings.arguments as Result;
    final monsterProvider =
        Provider.of<MonsterProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          monster.name,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('${monster.name} agregado a favoritos');
            },
            icon: const Icon(Icons.favorite_border_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: monsterProvider.getMonsterDetails(monster.index),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            MonsterDetails monsterData = snapshot.data! as MonsterDetails;
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    _Description(monster: snapshot.data as MonsterDetails),
                    if (monsterData.image != null)
                      _MonsterImage(size: size, image: monsterData.image!),
                    Stats(
                      strength: monsterData.strength,
                      dexterity: monsterData.dexterity,
                      constitution: monsterData.constitution,
                      intelligence: monsterData.intelligence,
                      wisdom: monsterData.wisdom,
                      charisma: monsterData.charisma,
                    ),
                    if (monsterData.specialAbilities != null)
                      _SpecialAbilities(
                          abilities: monsterData.specialAbilities!),
                    _Actions(monsterActions: monsterData.actions),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}

class _SpecialAbilities extends StatelessWidget {
  const _SpecialAbilities({required this.abilities});

  final List<SpecialAbility> abilities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Special Abilities',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: abilities.map((e) {
            return Padding(
              padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    children: [
                      TextSpan(
                        text: '${e.name}: ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: e.desc,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.monsterActions,
  });

  final List<MonsterDetailsAction> monsterActions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: monsterActions.map((e) {
            return Padding(
              padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    children: [
                      TextSpan(
                        text: '${e.name}:\n',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: e.desc,
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MonsterImage extends StatelessWidget {
  const _MonsterImage({
    required this.size,
    required this.image,
  });

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).primaryColorDark, width: 10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: 300,
      child: FadeInImage(
        placeholder: const AssetImage('assets/loading.gif'),
        image: NetworkImage('http://www.dnd5eapi.co${image}'),
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({super.key, required this.monster});

  final MonsterDetails monster;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
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
