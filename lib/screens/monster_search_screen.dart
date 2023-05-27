import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/favorite.dart';
import 'package:proyecto_final/models/monster_info.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';

class MonsterSearch extends StatelessWidget {
  const MonsterSearch({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> crList = [
      "0",
      "1/8",
      "1/4",
      "1/2",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Rating'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: _CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: crList.length,
          itemBuilder: (_, index) {
            return _GridElement(
              challenge: crList[index],
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class _GridElement extends StatelessWidget {
  const _GridElement({required this.challenge, required this.index});

  final String challenge;
  final int index;

  @override
  Widget build(BuildContext context) {
    int redValue = 30 + 140 * index ~/ 23;
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'challengeRating', arguments: challenge),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Color.fromARGB(255, redValue.toInt(), 10, 10),
          child: Center(
            child: Text(
              challenge,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
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
    final monsterInfoProvider =
        Provider.of<MonsterInfoProvider>(context, listen: true);
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
          onTap: () {
            FavoriteModel temp = FavoriteModel(
                slug: monster.slug,
                name: monster.name,
                hp: monster.hitPoints.toString(),
                type: monster.type,
                size: monster.size);
            Navigator.pushNamed(context, 'monsterDetails', arguments: temp);
          },
        );
      },
    );
  }
}
