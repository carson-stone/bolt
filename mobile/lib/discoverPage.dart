import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiscoverPage extends StatelessWidget {
  String id;
  Function updateFeed;

  DiscoverPage(this.id, this.updateFeed);

  void follow(String followed) {
    String url = 'http://localhost:6000/users/follow';
    http.post(url, body: {'id': id, 'followed': followed});
    updateFeed(id);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('user 1'),
            onTap: () {},
          ),
          ListTile(
            title: Text('user 2'),
            onTap: () {},
          ),
          ListTile(
            title: Text('nick'),
            onTap: () {
              // set up button
              Widget okButton = FlatButton(
                color: Theme.of(context).accentColor,
                child: Text("Yes"),
                onPressed: () {
                  follow('5e50904dcab45d20c70d9c8b');
                  Navigator.pop(context);
                },
              );

              // set up AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Follow nick?"),
                content:
                    Text("You will be able to see their bolts on your feed."),
                actions: [
                  okButton,
                ],
              );

              // show dialog
              showDialog(
                context: context,
                builder: (BuildContext context) => alert,
              );
            },
          ),
        ],
      ),
    );
  }
}
