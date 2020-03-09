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
    super.initState();
    getBolts();
    followingCount = 0;
    followerCount = 0;
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

    Widget profilePic = user['profilePic'] == null
        ? Container(
            color: randomizedProfilePics[randomColorIndex][0],
            padding: EdgeInsets.all(12),
            child: Image.asset(
              randomizedProfilePics[randomColorIndex][1],
            ),
          )
        : Container(
            child: Image.network(
              user['profilePic'],
              fit: BoxFit.cover,
            ),
          );

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
                      child: Camera(id, username, getBolts),
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
            child: Container(
              width: double.infinity,
              height: 400,
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
                        builder: (context) => BoltDetail(
                          username,
                          bolts[0]['imageUrl'],
                          id,
                          bolts[0]['description'],
                        ),
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
                  child: profilePic,
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
            height: 600,
            alignment: Alignment.center,
            child: PageView(
              controller: PageController(
                initialPage: 0,
              ),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    boltWidget,
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        sparkWidget(
                          context,
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/9/95/Trapper_Mountain_7530%27.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        sparkWidget(
                          context,
                          child: Image.network(
                            'https://static.seattletimes.com/wp-content/uploads/2018/09/09052018_K2_182653-1020x665.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        sparkWidget(
                          context,
                          child: Image.network(
                            'https://ichef.bbci.co.uk/images/ic/640x360/p0659ssc.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        sparkWidget(
                          context,
                          child: Image.network(
                            'https://3.bp.blogspot.com/-ePUyYcIsyuM/UQfToV8iKFI/AAAAAAAAgqs/OMdAD5WoOSg/s1600/snowy-mountains-vijayendra-bapte.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'sndfksndfk kjdsnfk jnsdfjknfkj n wdwn kdn kn knk en rkerngk enfkj n wdwn kdn kn knk en rkerngk enf',
                          textAlign: TextAlign.center,
                        ),
                        height: 80,
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            appBar: AppBar(
                              bottom: TabBar(
                                tabs: <Widget>[
                                  Tab(
                                    child: Text(
                                      'following',
                                      style: Theme.of(context).textTheme.body2,
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'followers',
                                      style: Theme.of(context).textTheme.body2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            body: TabBarView(
                              children: <Widget>[
                                ListView(
                                  children: List.generate(
                                    followingCount,
                                    (index) => ListTile(
                                      title: Text(
                                        user['following'][index]['username'],
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                    ),
                                  ),
                                ),
                                ListView(
                                  children: List.generate(
                                    followerCount,
                                    (index) => ListTile(
                                      title: Text(
                                        user['followers'][index]['username'],
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
