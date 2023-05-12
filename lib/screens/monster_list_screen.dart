import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/monster_provider.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

class MonsterListScreen extends StatefulWidget {
  const MonsterListScreen({super.key});

  @override
  State<MonsterListScreen> createState() => _MonsterListScreenState();
}

class _MonsterListScreenState extends State<MonsterListScreen> {
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    final monsterProvider = Provider.of<MonsterProvider>(context, listen: true);

    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Monster'),
        onSearch: (searchValue) {
          monsterProvider.filterMonsterList(searchValue);
        },
        suggestions: monsterProvider.suggestions.values.toList(),
        onSuggestionTap: (data) => Navigator.pushNamed(
            context, 'monster details',
            arguments: monsterProvider.getMonsterDetailsFromName(data)),
      ),
      // AppBar(
      //   title: const Text('Monsters'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         print('Busqueda');
      //       },
      //       icon: const Icon(Icons.search),
      //     ),
      //   ],
      // ),
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
