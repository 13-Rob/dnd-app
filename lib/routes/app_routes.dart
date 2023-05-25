import 'package:flutter/material.dart';
import 'package:proyecto_final/models/menu_options.dart';
import 'package:proyecto_final/screens/challenge_rating_screen.dart';
import 'package:proyecto_final/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = [
    MenuOption(
      route: 'monstersMenu',
      icon: Icons.warning,
      name: 'Monsters Menu',
      screen: const MonsterSearch(),
    ),
    MenuOption(
      route: 'challengeRating',
      name: 'Challenge Rating',
      screen: const ChallengeRatingScreen(),
    )
  ];

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({
      'home': (_) => const HomeScreen(),
      'monsterDetails': (_) => const MonsterScreen(),
    });

    for (var option in menuOptions) {
      appRoutes.addAll({option.route: (_) => option.screen});
    }

    return appRoutes;
  }
}
