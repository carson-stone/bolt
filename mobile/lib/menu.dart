import 'package:flutter/material.dart';

import './aboutPage.dart';

class Menu extends StatefulWidget {
  Function setLoggedIn;
  String username, id;

  Menu.fromAnotherPage();

  Menu(this.setLoggedIn, {this.username, this.id});

  @override
  _MenuState createState() => _MenuState(setLoggedIn, username, id);
}

class _MenuState extends State<Menu> {
  Function setLoggedIn;
  String username, id;

  _MenuState(this.setLoggedIn, this.username, this.id);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      DrawerHeader(
        child: GestureDetector(
          child: Container(
            child: Text(
              username,
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            DefaultTabController.of(context).animateTo(2); //go to profile
          },
        ),
      ),
      ListTile(
        title: Text('about bolt'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AboutPage(id, () {}, setLoggedIn)));
        },
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
