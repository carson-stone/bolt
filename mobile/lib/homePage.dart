import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: List.generate(50, (index) {
          return ListTile(
            title: Center(
              child: Text(
                'home',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            onTap: () {},
          );
        }),
      ),
    );
  }
}
