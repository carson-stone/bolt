import 'package:flutter/material.dart';

import './homePage.dart';
import './discoverPage.dart';
import './profilePage.dart';
import './menu.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  State createState() {
    return new AppState();
  }
}

class AppState extends State<App> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bolt',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Menu(),
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
              HomePage(),
              DiscoverPage(),
              ProfilePage(),
            ],
          ),
        ),
      ),
      theme: ThemeData(
        primaryColor: Colors.grey,
        accentColor: Colors.purple,
      ),
    );
  }
}
