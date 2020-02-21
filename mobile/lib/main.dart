import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './homePage.dart';
import './discoverPage.dart';
import './profilePage.dart';
import './menu.dart';
import './styles.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool loggedIn = false;
  Map<String, dynamic> user = {'name': 'bolt', 'feed': [], 'id': ''};

  void setLoggedIn(bool logIn, String username, String id) async {
    List feed = [];

    if (logIn) {
      String url = "http://localhost:6000/users/${id}/feed";
      var feedData = await http.get(url);
      feed = jsonDecode(feedData.body);
    }

    setState(() {
      loggedIn = logIn;
      user['name'] = username;
      user['id'] = id;
      user['feed'] = feed;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bolt',
      theme: ThemeData(
        primaryColor: Colors.grey[50],
        accentColor: Colors.purple,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          body1: BodyTextStyle(),
          body2: EmphasizedBodyTextStyle(),
        ),
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: Menu(loggedIn, setLoggedIn, username: user['name']),
          appBar: AppBar(
            title: Text('bolt'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.flash_on),
                onPressed: () {
                  print('pressed flash icon');
                },
              ),
            ],
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
              HomePage(user['feed']),
              DiscoverPage(),
              ProfilePage(user['id']),
            ],
          ),
        ),
      ),
    );
  }
}
