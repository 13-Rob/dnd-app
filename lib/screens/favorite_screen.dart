import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/favorite.dart';
import 'package:proyecto_final/providers/favorite_provider.dart';
import 'package:proyecto_final/widgets/custom_divider_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

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
        separatorBuilder: (_, __) => const CustomDivider(),
        itemCount: favoriteProvider.favorite.length,
        itemBuilder: (context, index) {
          FavoriteModel temp = favoriteProvider.favorite[index];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: const Icon(Icons.pets),
            title: Text(
              temp.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              '${temp.size} ${temp.type}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            trailing: Text(
              'HP: ${temp.hp}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              Navigator.pushNamed(context, 'monsterDetails', arguments: temp);
            },
            onLongPress: () {
              favoriteProvider.eraseFavByID(temp.id!);
            },
          );
        },
      ),
    );
  }
}
