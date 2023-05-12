import 'package:flutter/material.dart';
import 'package:proyecto_final/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto Final'),
      ),
      body: ListView.separated(
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(AppRoutes.menuOptions[index].name),
            onTap: () => Navigator.pushNamed(
                context, AppRoutes.menuOptions[index].route),
          );
        },
        separatorBuilder: (_, __) => const Divider(thickness: 1),
        itemCount: AppRoutes.menuOptions.length,
      ),
    );
  }
}
