import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/favorite_provider.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: true);
    final monsterInfoProvider = Provider.of<MonsterInfoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        actions: [
          IconButton(
            onPressed: () {
              favoriteProvider.eraseAll();
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: favoriteProvider.favorite.length,
        itemBuilder: (_, index) {
          return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const Icon(Icons.pets),
              title: Text(
                favoriteProvider.favorite[index].name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                '${favoriteProvider.favorite[index].size} ${favoriteProvider.favorite[index].type}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onTap: () {
                monsterInfoProvider
                    .getMonsterByName(
                        name: favoriteProvider.favorite[index].name)
                    .then((value) => Navigator.pushNamed(
                        context, "monsterDetails",
                        arguments: value));
              });
        },
      ),
    );
  }
}
