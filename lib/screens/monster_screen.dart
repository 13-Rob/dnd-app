import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/monster_info.dart' as mon;
import 'package:proyecto_final/providers/favorite_provider.dart';
import 'package:proyecto_final/widgets/custom_divider_widget.dart';
import 'package:proyecto_final/widgets/stats_widget.dart';

class MonsterScreen extends StatefulWidget {
  const MonsterScreen({super.key});

  @override
  State<MonsterScreen> createState() => _MonsterScreenState();
}

class _MonsterScreenState extends State<MonsterScreen> {
  Icon favoriteIcon = const Icon(Icons.favorite_border_outlined);

  @override
  Widget build(BuildContext context) {
    final mon.MonsterInfo monsterData =
        ModalRoute.of(context)?.settings.arguments as mon.MonsterInfo;
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    bool favorite =
        favoriteProvider.favorite.any((e) => e.name == monsterData.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          monsterData.name,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (favorite) {
                favoriteProvider.eraseFavByName(monsterData.name);
                setState(() {
                  favoriteIcon = const Icon(Icons.favorite_border);
                });
                favorite = false;
              } else {
                favoriteProvider.newFavorite(monsterData);
                setState(() {
                  favoriteIcon = const Icon(Icons.favorite_border_outlined);
                });
                favorite = true;
              }
            },
            icon:
                favoriteProvider.favorite.any((e) => e.name == monsterData.name)
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _MonsterHeader(monster: monsterData),
                _DescriptionAndImage(monster: monsterData),
                Stats(
                  monster: monsterData,
                ),
                const CustomDivider(),
                _Actions(actions: monsterData.actions),
                if (monsterData.specialAbilities!.isNotEmpty)
                  _NameAndDescList(
                      name: 'Special Abilities',
                      abilities: monsterData.specialAbilities!),
                if (monsterData.legendaryActions!.isNotEmpty)
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
  }
}

class _MonsterHeader extends StatelessWidget {
  const _MonsterHeader({required this.monster});

  final mon.MonsterInfo monster;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 12, left: 40, right: 40),
      child: Column(
        children: [
          Text(
            'Hit Points: ${monster.hitPoints} (${monster.hitDice})',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Armor Class: ${monster.armorClass}',
                style: const TextStyle(fontSize: 20),
              ),
              if (monster.speed.walk != null)
                Text(
                  'Speed: ${monster.speed.walk} ft.',
                  style: const TextStyle(fontSize: 20),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NameAndDescList extends StatelessWidget {
  const _NameAndDescList({required this.name, required this.abilities});

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
  const _Actions({required this.actions});

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
            placeholder: const AssetImage('assets/loading-icon.gif'),
            image: NetworkImage(
              monster.imgMain ??
                  'https://github.com/13-Rob/dnd-app/blob/main/assets/no-monster-image.png?raw=true',
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
