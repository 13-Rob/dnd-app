import 'package:flutter/material.dart';

class MonsterTiles extends StatelessWidget {
  const MonsterTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monsters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.red,
              ),
            );
          },
        ),
      ),
      // body: GridView.count(
      //   crossAxisSpacing: 6,
      //   mainAxisSpacing: 6,
      //   crossAxisCount: 2,
      //   padding: const EdgeInsets.all(8),
      //   children: <Widget>[
      //     ClipRRect(
      //       borderRadius: BorderRadius.circular(20),
      //       child: Container(
      //         color: Colors.red,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
