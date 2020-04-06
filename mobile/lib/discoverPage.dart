import 'package:bolt/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiscoverPage extends StatefulWidget {
  String id, username;
  Function updateFeed;
  List users = [];

  DiscoverPage(this.id, this.username, this.updateFeed);

  @override
  _DiscoverPageState createState() =>
      _DiscoverPageState(id, username, updateFeed);
}

class _DiscoverPageState extends State<DiscoverPage> {
  String id, username;
  Function updateFeed;
  List users = [];

  _DiscoverPageState(this.id, this.username, this.updateFeed);

  void getUsers() async {
    String url = 'http://localhost:6000/users/';
    var result = await http.get(url);
    setState(() {
      users = json.decode(result.body);
    });
  }

  void follow(String followedId, String followedUsername) async {
    String url = 'http://localhost:6000/users/follow';
    await http.post(url, body: {
      'id': id,
      'username': username,
      'followedId': followedId,
      'followedUsername': followedUsername
    });
    updateFeed(id);
  }

  void unfollow(String unfollowedId, String unfollowedUsername) async {
    String url = 'http://localhost:6000/users/unfollow';
    await http.post(url, body: {
      'id': id,
      'username': username,
      'unfollowedId': unfollowedId,
      'unfollowedUsername': unfollowedUsername
    });
    updateFeed(id);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          ...List.generate(
              users.length,
              (index) => ListTile(
                    title: Text(users[index]['username'],
                        style: Theme.of(context).textTheme.body2),
                    onTap: () {
                      Widget followButton = FlatButton(
                        color: Theme.of(context).accentColor,
                        child: Text("Follow"),
                        onPressed: () {
                          follow(users[index]['_id'], users[index]['username']);
                          Navigator.pop(context);
                        },
                      );
                      Widget unfollowButton = FlatButton(
                        child: Text("Unfollow"),
                        onPressed: () {
                          unfollow(
                              users[index]['_id'], users[index]['username']);
                          Navigator.pop(context);
                        },
                      );
                      Widget gotToProfileButton = FlatButton(
                        child: Text("Go to profile"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    title: Text(users[index]['username'] +
                                        "'s profile"),
                                  ),
                                  body: ProfilePage.notForCurrentUser(
                                      users[index]['_id'],
                                      users[index]['username']),
                                ),
                              ));
                        },
                      );

                      AlertDialog alert = AlertDialog(
                        title: Text(users[index]['username']),
                        content: Text("What would you like to do?"),
                        actions: [
                          followButton,
                          unfollowButton,
                          gotToProfileButton
                        ],
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) => alert,
                      );
                    },
                  )),
          RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              "Get Users",
              style: Theme.of(context).textTheme.title,
            ),
            onPressed: () {
              getUsers();
            },
          ),
        ],
      ),
    );
  }
}
