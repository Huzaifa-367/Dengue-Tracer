import 'package:flutter/material.dart';

import 'screens/card_column_screen.dart';
import 'screens/card_grid_screen.dart';
import 'screens/card_list_screen.dart';

class Staggered_animations extends StatelessWidget {
  const Staggered_animations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('List Card Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CardListScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Grid Card Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CardGridScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Column Card Test'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CardColumnScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
