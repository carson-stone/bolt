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
        bottom: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.search),
            ),
            Tab(
              icon: Icon(Icons.person),
            )
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Card(
            child: Text('home'),
          ),
          Card(
            child: Text('search'),
          ),
          Card(
            child: Text('user'),
          ),
        ],
      ),
    );
  }
}
