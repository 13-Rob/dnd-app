import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/ui_provider.dart';
import 'package:proyecto_final/widgets/custom_navigation_bar.dart';
import 'package:proyecto_final/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavgationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOption;

    switch (currentIndex) {
      case 0:
        return const WeaponsScreen();

      case 1:
        return const MonsterSearch();

      default:
        return const WeaponsScreen();
    }
  }
}
