import 'package:flutter/material.dart';

import './registerPage.dart';
import './loginPage.dart';

class Menu extends StatefulWidget {
  bool loggedIn;
  Function setLoggedIn;
  String username;

  Menu.fromAnotherPage();

  Menu(this.loggedIn, this.setLoggedIn, {this.username});

  @override
  _MenuState createState() => _MenuState(loggedIn, setLoggedIn, username);
}

class _MenuState extends State<Menu> {
  bool loggedIn;
  Function setLoggedIn;
  String username;

  _MenuState(this.loggedIn, this.setLoggedIn, this.username);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = !loggedIn
        ? <Widget>[
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
                  MaterialPageRoute(
                      builder: (context) => LoginPage(setLoggedIn)),
                );
              },
            ),
            ListTile(
              title: Text('register'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
            ListTile(
              title: Text('about bolt'),
              onTap: () {},
            ),
          ]
        : <Widget>[
            DrawerHeader(
              child: Container(
                child: Text(username),
              ),
            ),
            ListTile(
              title: Text('about bolt'),
              onTap: () {},
            ),
            ListTile(
              title: Text('log out'),
              onTap: () {
                setLoggedIn(false, 'bolt', '');
                Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
              },
            ),
          ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: children,
      ),
    );
  }
}
