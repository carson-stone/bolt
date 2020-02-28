import 'dart:ffi';

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

  Widget sparkWidget(context, {child}) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 80,
          width: 80,
          child: Container(
            color: Theme.of(context).canvasColor,
            child: Text(''),
          ),
        ),
      );

  Widget hotnessWidget() => Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Image.asset(
          'assets/transparent-bolt.png',
        ),
      );

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
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    // width: double.infinity,
                    width: 400,
                    height: 400,
                    child: Container(
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 115,
                      height: 115,
                      child: Camera(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '+ add bolt',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                ),
              ],
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              child: Container(
                child: Image.network(
                  bolts[0]['imageUrl'],
                  // height: 400,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BoltDetail(username,
                          bolts[0]['imageUrl'], id, bolts[0]['description']),
                    ));
              },
            ),
          );

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 180,
                      height: 35,
                      child: Text(
                        'User\'s Name',
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                    Container(
                      child: Text(
                        '@' + username,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        hotnessWidget(),
                        hotnessWidget(),
                        hotnessWidget(),
                        hotnessWidget(),
                        hotnessWidget(),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 25,
                ),
                sparkWidget(context),
                SizedBox(
                  width: 25,
                ),
                SizedBox(
                  width: 30,
                  child: Icon(
                    Icons.settings,
                    size: 30,
                    color: Theme.of(context).splashColor,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 1,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 400,
            alignment: Alignment.center,
            child: PageView(
              controller: PageController(
                initialPage: 0,
              ),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                boltWidget,
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 250,
                  alignment: Alignment.topCenter,
                  child: Text(
                    'sndfksndfk kjdsnfk jnsdfjknfkj n wdwn kdn kn knk en rkerngk enfkj n wdwn kdn kn knk en rkerngk enf',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              sparkWidget(context),
              sparkWidget(context),
              sparkWidget(context),
              sparkWidget(context),
            ],
          ),
        ],
      ),
    );
  }
}
