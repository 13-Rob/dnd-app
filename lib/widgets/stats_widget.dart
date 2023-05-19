import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({
    super.key,
    this.strength,
    this.dexterity,
    this.constitution,
    this.intelligence,
    this.wisdom,
    this.charisma,
  });

  final int? strength;
  final int? dexterity;
  final int? constitution;
  final int? intelligence;
  final int? wisdom;
  final int? charisma;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatDisplay(stat: ['STR', strength.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['DEX', dexterity.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['CON', constitution.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['INT', intelligence.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['WIS', wisdom.toString()]),
          const SizedBox(width: 20),
          _StatDisplay(stat: ['CHA', charisma.toString()]),
        ],
      ),
    );
  }
}

class _StatDisplay extends StatelessWidget {
  const _StatDisplay({super.key, required this.stat});

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
