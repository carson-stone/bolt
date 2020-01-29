import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Text('bolt'),
            ),
          ),
          ListTile(title: Text('about bolt'), onTap: () {})
        ],
      ),
    );
  }
}
