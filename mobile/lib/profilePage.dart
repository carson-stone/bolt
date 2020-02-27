import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './boltDetail.dart';
import './camera.dart';
import './aboutPage.dart';

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
      followingCount = userData['following'].length;
      followerCount = userData['followers'].length;
      bolts = usersBolts;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget boltWidget = bolts.length == 0
        ? Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: Container(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      child: Camera(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'add a bolt',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ],
                ),
              ],
            ),
          )
        : Column(
            children: <Widget>[
              ...List.generate(bolts.length, (index) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: GestureDetector(
                          child: Image.network(bolts[index]['imageUrl']),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BoltDetail(
                                      username,
                                      bolts[index]['imageUrl'],
                                      id,
                                      bolts[index]['description']),
                                ));
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Text(
                          bolts[index]['description'],
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          );

    return Center(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Text('about page'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                ),
                SizedBox(
                  height: 50,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(username,
                        style: Theme.of(context).textTheme.body2),
                  ),
                ),
                Container(
                  child: Text(
                    '$followerCount followers',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                ...List.generate(followerCount, (i) {
                  return Container(
                    child: Text(
                      user['followers'][i]['username'],
                      style: Theme.of(context).textTheme.body1,
                    ),
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
                    child: Text(
                      user['following'][i]['username'],
                      style: Theme.of(context).textTheme.body1,
                    ),
                  );
                }),
                boltWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
