import 'package:flutter/material.dart';

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
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.grey,
        accentColor: Colors.purple,
      ),
    );
  }
}
