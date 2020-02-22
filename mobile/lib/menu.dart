import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Function setLoggedIn;
  String username;

  Menu.fromAnotherPage();

  Menu(this.setLoggedIn, {this.username});

  @override
  _MenuState createState() => _MenuState(setLoggedIn, username);
}

class _MenuState extends State<Menu> {
  Function setLoggedIn;
  String username;

  _MenuState(this.setLoggedIn, this.username);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
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
