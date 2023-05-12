import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/monster.dart';
import 'package:proyecto_final/providers/monster_provider.dart';

class MonsterListScreen extends StatelessWidget {
  const MonsterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final monsterProvider = Provider.of<MonsterProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monsters'),
        actions: [
          IconButton(
            onPressed: () {
              print('Busqueda');
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
        future: monsterProvider.getMonsters(),
        builder: (_, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                height: 180,
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          final monsters = snapshot.data;

          return ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: monsters.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  monsters[index].name,
                ),
                onTap: () => Navigator.pushNamed(context, 'monster details',
                    arguments: monsters[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              thickness: 1,
            ),
          );
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final monsterProvider = Provider.of<MonsterProvider>(context);
    var searchTerms = monsterProvider.monsterList;
    List<Result> matchQuery = [];
    for (Result monster in searchTerms) {
      if (monster.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(monster);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        Result result = matchQuery[index];
        return ListTile(
          title: Text(result.name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final monsterProvider = Provider.of<MonsterProvider>(context);
    var searchTerms = monsterProvider.monsterList;
    List<Result> matchQuery = [];
    for (Result monster in searchTerms) {
      if (monster.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(monster);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        Result result = matchQuery[index];
        return ListTile(
          title: Text(result.name),
          onTap: () => Navigator.pushNamed(context, 'monster details',
              arguments: result),
        );
      },
    );
  }
}
