import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/db_provider.dart';
import 'package:proyecto_final/providers/favorite_provider.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';
import 'package:proyecto_final/providers/ui_provider.dart';
import 'package:proyecto_final/routes/app_routes.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider(create: (_) => UiProvider()),
          ChangeNotifierProvider(
            create: (_) => MonsterInfoProvider(),
            lazy: true,
          ),
        ],
        child: FutureBuilder(
          future: DBProvider.db.database,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const MyApp();
            }
            return const CupertinoActivityIndicator();
          },
        )
        // child: const MyApp(),
        );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getRoutes(),
      theme: ThemeData(primarySwatch: Colors.red).copyWith(
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 119, 22, 22)),
      ),
    );
  }
}
