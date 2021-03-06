import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './boltDetail.dart';
import './camera.dart';
import './aboutPage.dart';
import './hotness.dart';

class ProfilePage extends StatefulWidget {
  String id, username;
  bool showAddBolt = true;
  Function setLoggedIn;

  ProfilePage(this.id, this.username, this.setLoggedIn);
  ProfilePage.notFromMainView(this.id, this.username)
      : this.showAddBolt = false;

  @override
  _ProfilePageState createState() =>
      _ProfilePageState(id, username, showAddBolt, setLoggedIn);
}

class _ProfilePageState extends State<ProfilePage> {
  String id, username, bolt_id;
  int followingCount = 0, followerCount = 0;
  var user = {};
  var bolt;
  List sparks = [];
  bool showAddBolt;
  Function setLoggedIn;

  _ProfilePageState(this.id, this.username, this.showAddBolt, this.setLoggedIn);

  Widget sparkWidget(context, {child}) {
    var ch = child == null
        ? Container(
            color: Theme.of(context).canvasColor,
            child: Text(''),
          )
        : child;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 80,
        width: 80,
        child: ch,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
    followingCount = 0;
    followerCount = 0;
  }

  void getData() async {
    String url = 'http://localhost:6000/users/$id';
    var res = await http.get(url);
    var userData = json.decode(res.body);

    url = 'http://localhost:6000/users/$id/bolt';
    res = await http.get(url);
    var usersBolt = res.body == '' ? null : json.decode(res.body);

    url = 'http://localhost:6000/users/$id/sparks';
    res = await http.get(url);
    var usersSparks = json.decode(res.body);

    setState(() {
      user = userData;
      followingCount = userData['following'].length;
      followerCount = userData['followers'].length;
      bolt = usersBolt;
      if (usersBolt != null) {
        bolt_id = usersBolt['_id'];
      }
      sparks = usersSparks;
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
    Widget sparksListWidget = sparks.length == 0
        ? Container(
            height: 80,
            alignment: Alignment.center,
            child: Text(
              'No sparks',
              style: Theme.of(context).textTheme.body1,
            ),
          )
        : Container(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  sparks.length,
                  (index) => GestureDetector(
                        child: Container(
                          child: sparkWidget(
                            context,
                            child: Image.file(
                              File('/Users/carson/programming/bolt/mobile/' +
                                  sparks[index]['imageUrl']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BoltDetail(
                                sparks[index]['_id'],
                                username,
                                sparks[index]['imageUrl'],
                                id,
                                sparks[index]['description'],
                                parentBoltId: sparks[index]['parent_bolt_id'],
                                hotnessAmount: sparks[index]['sparks'].length,
                                heroTag: 'none',
                                user: {
                                  'id': id,
                                  'username': username,
                                },
                              ),
                            ),
                          );
                        },
                      )),
            ),
          );

    Random randomGen = Random();
    int randomColorIndex = randomGen.nextInt(randomizedProfilePics.length);

    Widget settingsWidget = setLoggedIn == null
        ? Container()
        : Container(
            padding: EdgeInsets.only(
              left: 25,
            ),
            child: SizedBox(
              width: 30,
              child: GestureDetector(
                child: Icon(
                  Icons.settings,
                  size: 30,
                  color: Theme.of(context).splashColor,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(id, getData, setLoggedIn),
                  ),
                ),
              ),
            ),
          );

    double profilePicAreaWidth = setLoggedIn == null ? 80 : 25;

    Widget profilePic = user == {}
        ? Row(
            children: <Widget>[
              SizedBox(
                width: profilePicAreaWidth,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Container(
                    color: randomizedProfilePics[randomColorIndex][0],
                    padding: EdgeInsets.all(12),
                    child: Image.asset(
                      randomizedProfilePics[randomColorIndex][1],
                    ),
                  ),
                ),
              ),
              settingsWidget,
            ],
          )
        : user['profilePic'] == ''
            ? Row(
                children: <Widget>[
                  SizedBox(
                    width: profilePicAreaWidth,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Container(
                        color: randomizedProfilePics[randomColorIndex][0],
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          randomizedProfilePics[randomColorIndex][1],
                        ),
                      ),
                    ),
                  ),
                  settingsWidget,
                ],
              )
            : Row(
                children: <Widget>[
                  SizedBox(
                    width: profilePicAreaWidth,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Container(
                        child: Image.network(
                          // user['profilePic'],
                          'https://i.telegraph.co.uk/multimedia/archive/03439/dude6_3439641b.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  settingsWidget,
                ],
              );

    Widget boltWidget = bolt == null
        ? showAddBolt
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
                          child: Camera(
                            id,
                            bolt_id,
                            username,
                            getData,
                            make: 'bolt',
                          ),
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
                        Text(
                          'no bolt',
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
                child: Container(
                  child: Image.file(
                    File('/Users/carson/programming/bolt/mobile/' +
                        bolt['imageUrl']),
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BoltDetail(
                        bolt['_id'],
                        username,
                        bolt['imageUrl'],
                        id,
                        bolt['description'],
                        hotnessAmount: bolt['sparks'].length,
                        user: {
                          'id': id,
                          'username': username,
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );

    Widget hotnessWidget;
    if (bolt == null && sparks.length == 0) {
      hotnessWidget = Container(
        height: 50,
      );
    } else if (bolt == null && sparks.length > 0) {
      int hotnessAmount = 0;
      for (int i = 0; i < sparks.length; ++i) {
        hotnessAmount += sparks[i]['sparks'].length;
      }
      hotnessWidget = Hotness(hotnessAmount);
    } else {
      int hotnessAmount = bolt['sparks'].length;
      for (int i = 0; i < sparks.length; ++i) {
        hotnessAmount += sparks[i]['sparks'].length;
      }
      hotnessWidget = Hotness(hotnessAmount);
    }

    String bioText = user.containsKey('bio') ? user['bio'] : 'no bio yet';

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
                    hotnessWidget,
                  ],
                ),
                profilePic,
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
                    Hero(
                      tag: 'bolt',
                      child: boltWidget,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    sparksListWidget,
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          bioText,
                          textAlign: TextAlign.center,
                        ),
                        height: 80,
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            appBar: AppBar(
                              bottom: PreferredSize(
                                preferredSize: Size.fromHeight(0),
                                child: TabBar(
                                  tabs: <Widget>[
                                    Tab(
                                      child: Text(
                                        'following',
                                        style:
                                            Theme.of(context).textTheme.body2,
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'followers',
                                        style:
                                            Theme.of(context).textTheme.body2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            body: TabBarView(
                              children: <Widget>[
                                ListView(
                                  children: List.generate(
                                    followingCount,
                                    (index) => ListTile(
                                      title: Text(
                                        '@' +
                                            user['following'][index]
                                                ['username'],
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Scaffold(
                                              backgroundColor: Theme.of(context)
                                                  .backgroundColor,
                                              appBar: AppBar(),
                                              body: ProfilePage.notFromMainView(
                                                user['following'][index]['id'],
                                                user['following'][index]
                                                    ['username'],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                ListView(
                                  children: List.generate(
                                    followerCount,
                                    (index) => ListTile(
                                      title: Text(
                                        '@' +
                                            user['followers'][index]
                                                ['username'],
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Scaffold(
                                              backgroundColor: Theme.of(context)
                                                  .backgroundColor,
                                              appBar: AppBar(),
                                              body: ProfilePage.notFromMainView(
                                                user['followers'][index]['id'],
                                                user['followers'][index]
                                                    ['username'],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
