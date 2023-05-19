import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/monster_info_provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final monsterInfo = Provider.of<MonsterInfoProvider>(context);
    monsterInfo.getMonsterDetails('aboleth');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: const Center(child: Text('Test Screen')),
    );
  }
}
