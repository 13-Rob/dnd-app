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
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black), color: Colors.white),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatDisplay(stat: ['STR', strength.toString()]),
          const SizedBox(width: 20),
          StatDisplay(stat: ['DEX', dexterity.toString()]),
          const SizedBox(width: 20),
          StatDisplay(stat: ['CON', constitution.toString()]),
          const SizedBox(width: 20),
          StatDisplay(stat: ['INT', intelligence.toString()]),
          const SizedBox(width: 20),
          StatDisplay(stat: ['WIS', wisdom.toString()]),
          const SizedBox(width: 20),
          StatDisplay(stat: ['CHA', charisma.toString()]),
        ],
      ),
    );
  }
}

class StatDisplay extends StatelessWidget {
  const StatDisplay({super.key, required this.stat});

  final List stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          stat[0],
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            stat[1],
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
