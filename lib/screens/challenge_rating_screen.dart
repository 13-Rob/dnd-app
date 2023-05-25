import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/monster_info.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';

class ChallengeRatingScreen extends StatelessWidget {
  const ChallengeRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final monsterProvider = Provider.of<MonsterInfoProvider>(context);
    final String challenge =
        ModalRoute.of(context)?.settings.arguments as String;

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
      body: Center(
        child: FutureBuilder(
          future: monsterProvider.getAllMonsterByCR(challenge),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              List<MonsterInfo> monsterDataList =
                  snapshot.data as List<MonsterInfo>;

              return SizedBox(
                width: double.infinity,
                height: size.height * 0.5,
                child: Swiper(
                  layout: SwiperLayout.STACK,
                  itemWidth: size.width * 0.8,
                  itemHeight: size.height * 0.4,
                  itemCount: monsterDataList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, 'monsterDetails',
                          arguments: monsterDataList[index]),
                      child: Container(
                        color: Colors.red,
                        child: Center(
                          child: Text(monsterDataList[index].name),
                        ),
                      ),
                    );
                  },
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

    // TODO: intenta realizar un find u otra funcion que no sea recorrer el for
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
