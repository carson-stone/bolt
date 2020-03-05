import 'package:flutter/material.dart';
import 'dart:math';
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
  double detailHeight;
  var user = {};
  List bolts = [];

  _ProfilePageState(this.id, this.username);

  Widget sparkWidget(context, {child}) {
    var ch = child != null
        ? child
        : Container(
            color: Theme.of(context).canvasColor,
            child: Text(''),
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 80,
        width: 80,
        child: ch,
      ),
    );
  }

  Widget hotnessWidget() => Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Image.asset(
          'assets/transparent-bolt.png',
        ),
      );

  @override
  void initState() {
    detailHeight = 400;
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

  var randomizedProfilePics = [
    [
      //red backgrounds
      Color.fromARGB(255, 224, 60, 76),
      'assets/transparent-bolt.png',
    ],
    [
      Color.fromARGB(255, 224, 60, 76),
      'assets/transparent-bolt-black.png',
    ],
    [
      Color.fromARGB(255, 224, 60, 76),
      'assets/transparent-bolt-white.png',
    ],
    [
      Color.fromARGB(255, 224, 60, 76),
      'assets/transparent-bolt-purple.png',
    ],
    [
      //blue backgrounds
      Color.fromARGB(255, 90, 183, 244),
      'assets/transparent-bolt-red.png',
    ],
    [
      Color.fromARGB(255, 90, 183, 244),
      'assets/transparent-bolt-black.png',
    ],
    [
      Color.fromARGB(255, 90, 183, 244),
      'assets/transparent-bolt-white.png',
    ],
    [
      Color.fromARGB(255, 90, 183, 244),
      'assets/transparent-bolt-purple.png',
    ],
    [
      //white backgrounds
      Colors.white,
      'assets/transparent-bolt-red.png',
    ],
    [
      Colors.white,
      'assets/transparent-bolt-black.png',
    ],
    [
      Colors.white,
      'assets/transparent-bolt.png',
    ],
    [
      Colors.white,
      'assets/transparent-bolt-purple.png',
    ],
    [
      //purple backgrounds
      Color.fromARGB(255, 133, 54, 170),
      'assets/transparent-bolt-red.png',
    ],
    [
      Color.fromARGB(255, 133, 54, 170),
      'assets/transparent-bolt-black.png',
    ],
    [
      Color.fromARGB(255, 133, 54, 170),
      'assets/transparent-bolt.png',
    ],
    [
      Color.fromARGB(255, 133, 54, 170),
      'assets/transparent-bolt-white.png',
    ],
  ]; // [background color, bolt color path]

  @override
  Widget build(BuildContext context) {
    Random randomGen = Random();
    int randomColorIndex = randomGen.nextInt(randomizedProfilePics.length);

    Widget boltWidget = bolts.length == 0
        ? Container(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
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
        : Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                child: Hero(
                  tag: 'bolt',
                  child: Image.network(
                    bolts[0]['imageUrl'],
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
                        username,
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
                sparkWidget(
                  context,
                  child: Container(
                    color: randomizedProfilePics[randomColorIndex][0],
                    padding: EdgeInsets.all(12),
                    child: Image.asset(
                      randomizedProfilePics[randomColorIndex][1],
                    ),
                  ),
                ),
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
            height: 60,
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
