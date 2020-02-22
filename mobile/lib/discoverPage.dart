import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiscoverPage extends StatelessWidget {
  String id;
  Function updateFeed;

  DiscoverPage(this.id, this.updateFeed);

  void follow(String followed) async {
    String url = 'http://localhost:6000/users/follow';
    await http.post(url, body: {'id': id, 'followed': followed});
    updateFeed(id);
  }

  void unfollow(String unfollowed) async {
    String url = 'http://localhost:6000/users/unfollow';
    await http.post(url, body: {'id': id, 'unfollowed': unfollowed});
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
              // set up buttons
              Widget followButton = FlatButton(
                color: Theme.of(context).accentColor,
                child: Text("Follow"),
                onPressed: () {
                  follow('5e50904dcab45d20c70d9c8b');
                  Navigator.pop(context);
                },
              );
              Widget unfollowButton = FlatButton(
                child: Text("Unfollow"),
                onPressed: () {
                  unfollow('5e50904dcab45d20c70d9c8b');
                  Navigator.pop(context);
                },
              );

              // set up AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("nick"),
                content: Text("What would you like to do?"),
                actions: [followButton, unfollowButton],
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
