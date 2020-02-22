import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  String id, username;
  List bolts = [];

  ProfilePage(this.id, this.username);

  @override
  _ProfilePageState createState() => _ProfilePageState(id, username);
}

class _ProfilePageState extends State<ProfilePage> {
  String id, username;
  int followingCount = 0, followerCount = 0;
  var user = {};
  List bolts = [];

  _ProfilePageState(this.id, this.username);

  @override
  void initState() {
    super.initState();
    getBolts();
  }

  void getBolts() async {
    String url = 'http://localhost:6000/users/$id';
    var res = await http.get(url);
    var userData = json.decode(res.body);

    url = 'http://localhost:6000/users/$id/bolts';
    res = await http.get(url);
    List usersBolts = json.decode(res.body);

    setState(() {
      user = userData;
      followingCount = user['following'].length;
      followerCount = user['followers'].length;
      bolts = usersBolts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Theme.of(context).accentColor,
                  child:
                      Text(username, style: Theme.of(context).textTheme.body2),
                ),
                Container(
                  child: Text(
                    '$followerCount followers',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                ...List.generate(followerCount, (i) {
                  return Container(
                    child: Text(user['followers'][i]['username']),
                  );
                }),
                Container(
                  child: Text(
                    'following $followingCount',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                ...List.generate(followingCount, (i) {
                  return Container(
                    child: Text(user['following'][i]['username']),
                  );
                }),
              ],
            ),
          ),
          ...List.generate(bolts.length, (index) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: Image.network(bolts[index]['imageUrl']),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          bolts[index]['description'],
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
