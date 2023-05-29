import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/favorite.dart';
import 'package:proyecto_final/models/monster_info.dart' as mon;
import 'package:proyecto_final/providers/favorite_provider.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';
import 'package:proyecto_final/widgets/custom_divider_widget.dart';
import 'package:proyecto_final/widgets/stats_widget.dart';

class MonsterScreen extends StatefulWidget {
  const MonsterScreen({super.key});

  @override
  State<MonsterScreen> createState() => _MonsterScreenState();
}

class _MonsterScreenState extends State<MonsterScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    final monsterProvider = Provider.of<MonsterInfoProvider>(context);

    FavoriteModel monster =
        ModalRoute.of(context)?.settings.arguments as FavoriteModel;

    bool favorite =
        favoriteProvider.favorite.any((e) => e.name == monster.name);

    Icon favoriteIcon = favorite
        ? const Icon(Icons.favorite)
        : const Icon(Icons.favorite_border);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          monster.name,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (favorite) {
                favorite = false;
                setState(() {
                  favoriteIcon = const Icon(Icons.favorite_border);
                  favoriteProvider.eraseFavByName(monster.name);
                });
              } else {
                favorite = true;
                setState(() {
                  favoriteIcon = const Icon(Icons.favorite);
                  favoriteProvider.newFavorite(monster);
                });
              }
            },
            icon: favoriteIcon,
          ),
        ],
      ),
      body: FutureBuilder(
        future: monsterProvider.getMonsterDetails(monster.slug),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: $snapshot.error");
          } else if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Center(child: Text("Unable to load Monster Data"));
            }
            mon.MonsterInfo monsterData = snapshot.data as mon.MonsterInfo;
            return SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
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
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
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
  }
}

class _DescriptionAndImage extends StatelessWidget {
  const _DescriptionAndImage({required this.monster});

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
