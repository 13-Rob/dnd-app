import 'package:flutter/material.dart';
import 'package:proyecto_final/models/menu_options.dart';
import 'package:proyecto_final/screens/screens.dart';
import 'package:proyecto_final/screens/test_screen.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = [
    MenuOption(
      route: 'rules',
      icon: Icons.rule,
      name: 'Rules',
      screen: const RulesScreen(),
    ),
    MenuOption(
      route: 'monsters',
      icon: Icons.warning,
      name: 'Monsters',
      screen: const MonsterListScreen(),
    ),
    MenuOption(
      route: 'test',
      icon: Icons.telegram,
      name: 'Test',
      screen: const TestScreen(),
    )
  ];

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({
      'home': (_) => const HomeScreen(),
      'monster details': (_) => const MonsterScreen(),
    });

    for (var option in menuOptions) {
      appRoutes.addAll({option.route: (_) => option.screen});
    }

    return appRoutes;
  }
}
