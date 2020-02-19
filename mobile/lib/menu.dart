import 'package:flutter/material.dart';

import './registerPage.dart';
import './loginPage.dart';

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
          ListTile(
              title: Text('login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }),
          ListTile(
              title: Text('register'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              }),
          ListTile(title: Text('about bolt'), onTap: () {}),
        ],
      ),
    );
  }
}
