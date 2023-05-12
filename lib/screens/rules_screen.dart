import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return const ListTile(
          leading: Icon(Icons.star),
          title: Text('Adventuring'),
          subtitle: Text('Adventuring'),
        );
      },
      separatorBuilder: (_, __) => const Divider(thickness: 1),
      itemCount: 6,
    );
  }
}
