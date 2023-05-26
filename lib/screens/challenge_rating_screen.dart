import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/favorite.dart';
import 'package:proyecto_final/models/monster_info.dart';
import 'package:proyecto_final/providers/favorite_provider.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';

class ChallengeRatingScreen extends StatelessWidget {
  const ChallengeRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final monsterProvider = Provider.of<MonsterInfoProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    final String challenge =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Challenge Rating $challenge'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: _CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: monsterProvider.getAllMonsterByCR(challenge),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              List<MonsterInfo> monsterDataList =
                  snapshot.data as List<MonsterInfo>;
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      crossAxisCount: 2,
                    ),
                    itemCount: monsterDataList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          FavoriteModel temp = FavoriteModel(
                            slug: monsterDataList[index].slug,
                            name: monsterDataList[index].name,
                            hp: monsterDataList[index].hitPoints.toString(),
                            type: monsterDataList[index].type,
                            size: monsterDataList[index].size,
                          );
                          Navigator.pushNamed(context, 'monsterDetails',
                              arguments: temp);
                        },
                        child: _GridItem(
                            monsterDataList: monsterDataList, index: index),
                      );
                    },
                  ),
                ),
              );
            }
            return const CupertinoActivityIndicator();
          },
        ),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({
    required this.monsterDataList,
    required this.index,
  });

  final List<MonsterInfo> monsterDataList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: const Color.fromARGB(255, 86, 86, 86),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HP: ${monsterDataList[index].hitPoints}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 227, 227, 227),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                monsterDataList[index].name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${monsterDataList[index].size} ${monsterDataList[index].type}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 227, 226, 226),
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    final monsterInfoProvider = Provider.of<MonsterInfoProvider>(context);
    return [
      IconButton(
        onPressed: () {
          monsterInfoProvider.monsterList = [];
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final monsterInfoProvider = Provider.of<MonsterInfoProvider>(context);
    return IconButton(
      onPressed: () {
        monsterInfoProvider.monsterList = [];
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final monsterInfoProvider = Provider.of<MonsterInfoProvider>(context);
    List<MonsterInfo> searchTerms = monsterInfoProvider.monsterList;
    List<MonsterInfo> matchQuery = [];

    matchQuery = [
      ...searchTerms
          .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
          .toList()
    ];

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (_, index) {
        MonsterInfo monster = matchQuery[index];
        return ListTile(
          title: Text(monster.name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final monsterInfoProvider = Provider.of<MonsterInfoProvider>(context);
    monsterInfoProvider.getMonsters(query);
    List<MonsterInfo> searchTerms = monsterInfoProvider.monsterList;
    List<MonsterInfo> matchQuery = [];

    matchQuery = [
      ...searchTerms
          .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
          .toList()
    ];

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (_, index) {
        MonsterInfo monster = matchQuery[index];
        return ListTile(
          title: Text(monster.name),
          onTap: () => Navigator.pushNamed(context, 'monsterDetails',
              arguments: monster.name),
        );
      },
    );
  }
}
