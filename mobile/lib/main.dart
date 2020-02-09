import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './homePage.dart';
import './discoverPage.dart';
import './profilePage.dart';
import './menu.dart';
import './styles.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  State createState() {
    return new AppState();
  }
}

class AppState extends State<App> {
  Future getFeed() async {
    String url = 'http://localhost:6000';
    var response = await http.get(url);

    // // set up button
    // Widget okButton = FlatButton(
    //   child: Text("OK"),
    //   onPressed: () {},
    // );

    // // set up AlertDialog
    // AlertDialog alert = AlertDialog(
    //   title: Text("My title"),
    //   content: Text("This is my message."),
    //   actions: [
    //     okButton,
    //   ],
    // );

    // // show dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
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
          drawer: Menu(),
          appBar: AppBar(
            title: Text('welcome to bolt!'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.flash_on),
                onPressed: () {
                  getFeed();
                  print('ok');
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
              HomePage(),
              DiscoverPage(),
              ProfilePage(),
            ],
          ),
        ),
      ),
    );
  }
}
