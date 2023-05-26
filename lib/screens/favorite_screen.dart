import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/favorite.dart';
import 'package:proyecto_final/providers/favorite_provider.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';
import 'package:proyecto_final/widgets/custom_divider_widget.dart';

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
      body: ListView.separated(
        itemCount: favoriteProvider.favorite.length,
        separatorBuilder: (_, index) => const CustomDivider(),
        itemBuilder: (_, index) {
          FavoriteModel favoriteInfo = favoriteProvider.favorite[index];
          return _FavoriteTile(
              favoriteInfo: favoriteInfo,
              monsterInfoProvider: monsterInfoProvider);
        },
      ),
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({
    super.key,
    required this.favoriteInfo,
    required this.monsterInfoProvider,
  });

  final FavoriteModel favoriteInfo;
  final MonsterInfoProvider monsterInfoProvider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: const Icon(Icons.pets),
      title: Text(
        favoriteInfo.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        '${favoriteInfo.size} ${favoriteInfo.type}',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      trailing: Text(
        'HP: ${favoriteInfo.hp}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: () {
        monsterInfoProvider.getMonsterByName(name: favoriteInfo.name).then(
            (value) => Navigator.pushNamed(context, "monsterDetails",
                arguments: value));
      },
    );
  }
}
