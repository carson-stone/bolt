import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('home'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
