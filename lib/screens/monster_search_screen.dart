import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/monster_info.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';

class MonsterSearch extends StatelessWidget {
  const MonsterSearch({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> cr = ["0", "1", "2", "3", "4", "5"];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monsters'),
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
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: cr.length,
          itemBuilder: (_, index) {
            return _GridElement(challenge: cr[index]);
          },
        ),
      ),
    );
  }
}

class _GridElement extends StatelessWidget {
  const _GridElement({
    super.key,
    required this.challenge,
  });

  final String challenge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'challengeRating', arguments: challenge),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: const Color.fromARGB(255, 86, 86, 86),
          child: Center(
            child: Text(
              'Challenge Rating $challenge',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 25,
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
    for (MonsterInfo monster in searchTerms) {
      if (monster.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(monster);
      }
    }

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
    for (MonsterInfo monster in searchTerms) {
      if (monster.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(monster);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (_, index) {
        MonsterInfo monster = matchQuery[index];
        return ListTile(
          title: Text(monster.name),
          onTap: () => Navigator.pushNamed(context, 'monsterDetails',
              arguments: monster),
        );
      },
    );
  }
}
