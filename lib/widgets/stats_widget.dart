import 'package:flutter/material.dart';
import 'package:proyecto_final/models/monster_info.dart';

class Stats extends StatelessWidget {
  const Stats({super.key, required this.monster});

  final MonsterInfo monster;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatDisplay(stat: ['STR', monster.strength.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['DEX', monster.dexterity.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['CON', monster.constitution.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['INT', monster.intelligence.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['WIS', monster.wisdom.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['CHA', monster.charisma.toString()]),
        ],
      ),
    );
  }
}

class _StatDisplay extends StatelessWidget {
  const _StatDisplay({required this.stat});

  final List stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            stat[0],
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            stat[1],
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
