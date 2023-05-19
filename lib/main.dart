import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';
import 'package:proyecto_final/providers/monster_provider.dart';
import 'package:proyecto_final/providers/results_provider.dart';
import 'package:proyecto_final/routes/app_routes.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ResultsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => MonsterProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => MonsterInfoProvider(),
          lazy: true,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'test',
      routes: AppRoutes.getRoutes(),
      theme: ThemeData(primarySwatch: Colors.red).copyWith(
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 119, 22, 22)),
      ),
    );
  }
}
