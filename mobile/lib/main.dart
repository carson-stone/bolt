import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './homePage.dart';
import './discoverPage.dart';
import './profilePage.dart';
import './menu.dart';
import './splashScreen.dart';
import './styles.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool loggedIn = false;
  Map<String, dynamic> user = {'name': 'bolt', 'feed': [], 'id': ''};

  Future<List> updateFeed(String id) async {
    String url = "http://localhost:6000/users/${id}/feed";
    var feedData = await http.get(url);
    var feed = jsonDecode(feedData.body);
    if (loggedIn) {
      setState(() {
        user['feed'] = feed;
      });
    }
    return feed;
  }

  void setLoggedIn(bool logIn, String username, String id) async {
    List feed = [];

    if (logIn) {
      feed = await updateFeed(id);
    }

    setState(() {
      loggedIn = logIn;
      user['name'] = username;
      user['id'] = id;
      user['feed'] = feed;
    });
  }

  Widget build(BuildContext context) {
    Widget homeWidget = loggedIn
        ? DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Color.fromARGB(255, 33, 34, 39),
              // drawer: Menu(setLoggedIn, username: user['name'], id: user['id']),
              appBar: AppBar(
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: TabBar(
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
              ),
              body: TabBarView(
                children: <Widget>[
                  HomePage(
                    user['feed'],
                    user: {
                      'username': user['name'],
                      'id': user['id'],
                    },
                  ),
                  DiscoverPage(user['id'], user['name'], updateFeed),
                  ProfilePage(user['id'], user['name'], setLoggedIn),
                ],
              ),
            ),
          )
        : SplashScreen(setLoggedIn);

    return MaterialApp(
      title: 'bolt',
      theme: ThemeData(
        accentColor: Color.fromARGB(255, 90, 183, 244),
        backgroundColor: Color.fromARGB(255, 33, 34, 39),
        primaryColor: Color.fromARGB(255, 33, 34, 39),
        canvasColor: Color.fromARGB(255, 120, 120, 120),
        splashColor: Color.fromARGB(255, 133, 54, 170),
        brightness: Brightness.dark,
        textTheme: Typography.whiteMountainView.copyWith(
          body1:
              GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.w500),
          body2:
              GoogleFonts.quicksand(fontSize: 22, fontWeight: FontWeight.w500),
          button:
              GoogleFonts.quicksand(fontSize: 22, fontWeight: FontWeight.w500),
          title:
              GoogleFonts.quicksand(fontSize: 34, fontWeight: FontWeight.w500),
          headline:
              GoogleFonts.quicksand(fontSize: 65, fontWeight: FontWeight.w500),
        ),
      ),
      home: homeWidget,
    );
  }
}
