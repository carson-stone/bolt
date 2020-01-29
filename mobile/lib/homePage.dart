import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
      ),
      appBar: AppBar(
        title: Text('welcome to bolt!'),
      ),
      body: Card(
        child: Text('hello'),
      ),
    );
  }
}
