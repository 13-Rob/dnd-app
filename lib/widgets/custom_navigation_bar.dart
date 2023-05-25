import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/ui_provider.dart';

class CustomNavgationBar extends StatelessWidget {
  const CustomNavgationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOption;

    return BottomNavigationBar(
      onTap: (value) => uiProvider.selectedMenuOption = value,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pets),
          label: 'Monsters',
        ),
      ],
    );
  }
}
