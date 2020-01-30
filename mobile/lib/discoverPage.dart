import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('user 1'),
            onTap: () {},
          ),
          ListTile(
            title: Text('user 2'),
            onTap: () {},
          ),
          ListTile(
            title: Text('user 3'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
