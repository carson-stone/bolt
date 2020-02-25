import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
