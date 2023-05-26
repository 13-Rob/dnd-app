import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll(
      {
        'home': (_) => const HomeScreen(),
        'monsterDetails': (_) => const MonsterScreen(),
        'monsterMenu': (_) => const MonsterSearch(),
        'challengeRating': (_) => const ChallengeRatingScreen(),
      },
    );

    return appRoutes;
  }
}
