import 'package:flutter/material.dart';

import './menu.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu.fromAnotherPage(),
      // drawer: Menu(setLoggedIn, username: user['name'], id: user['id']),
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: Container(
              child: Text('about bolt'),
            ),
          ),
        ],
      ),
    );
  }
}
