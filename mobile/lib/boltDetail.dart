import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './profilePage.dart';
import './camera.dart';
import './hotness.dart';

class BoltDetail extends StatefulWidget {
  var user;
  String _id, username, imageUrl, user_id, description, heroTag, parentBoltId;

  BoltDetail(this._id, this.username, this.imageUrl, this.user_id,
      this.description, this.heroTag,
      {this.parentBoltId, @required this.user});

  @override
  _BoltDetailState createState() => _BoltDetailState(_id, username, imageUrl,
      user_id, description, heroTag, parentBoltId, user);
}

class _BoltDetailState extends State<BoltDetail> {
  String _id, username, imageUrl, user_id, description, heroTag, parentBoltId;
  List sparks = [];
  var parentBolt, user;

  _BoltDetailState(this._id, this.username, this.imageUrl, this.user_id,
      this.description, this.heroTag, this.parentBoltId, this.user);

  @override
  void initState() {
    super.initState();
    if (parentBoltId == '') {
      parentBoltId = null;
    }
    getData();
  }

  void getData() async {
    String url = 'http://localhost:6000/bolts/$_id/sparks';
    var res = await http.get(url);
    List boltsSparksIds = json.decode(res.body);

    List boltsSparks = [];
    url = 'http://localhost:6000/bolts/';
    for (int i = 0; i < boltsSparksIds.length; ++i) {
      res = await http.get(url + boltsSparksIds[i]);
      boltsSparks.add(json.decode(res.body));
    }

    var sparksParentBolt;
    if (parentBoltId != null) {
      url = 'http://localhost:6000/bolts/$parentBoltId';
      res = await http.get(url);
      sparksParentBolt = json.decode(res.body);
    }

    setState(() {
      sparks = boltsSparks;
      if (parentBoltId != null) {
        parentBolt = sparksParentBolt;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController horizontalController = PageController(
      initialPage: 0,
    );
    PageController verticalController = PageController(
      initialPage: 1,
    );

    return parentBoltId == null
        ? PageView(
            controller: horizontalController,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(2, 40, 2, 0),
                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 775,
                          padding: EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          child: GestureDetector(
                            child: Hero(
                              tag: heroTag,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Hero(
                            tag: 'row',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    child: Text(
                                      username,
                                      style: Theme.of(context).textTheme.body2,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                          backgroundColor:
                                              Theme.of(context).backgroundColor,
                                          appBar: AppBar(),
                                          body: ProfilePage.notFromMainView(
                                            user_id,
                                            username,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Hotness(5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.95),
                    child: Camera(
                      user['id'],
                      _id,
                      user['username'],
                      getData,
                      make: 'spark',
                    ),
                  ),
                ],
              ),
              ...List.generate(
                sparks.length,
                (index) => Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(2, 40, 2, 0),
                      color: Theme.of(context).backgroundColor,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 775,
                            padding: EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            child: GestureDetector(
                              child: Hero(
                                tag: heroTag,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    sparks[index]['imageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              onTap: () {
                                horizontalController.animateToPage(
                                  0,
                                  duration: Duration(
                                    milliseconds: 300,
                                  ),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    child: Text(
                                      sparks[index]['username'],
                                      style: Theme.of(context).textTheme.body2,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                          backgroundColor:
                                              Theme.of(context).backgroundColor,
                                          appBar: AppBar(),
                                          body: ProfilePage.notFromMainView(
                                            sparks[index]['user_id'],
                                            sparks[index]['username'],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Hotness(5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.95),
                      child: Camera(
                        user['id'],
                        _id,
                        user['username'],
                        getData,
                        make: 'spark',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        // parent bolt id is not null
        : parentBolt == null
            //didn't load yet
            ? Container()
            //parent loaded
            : PageView(
                //parent loaded
                controller: verticalController,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(2, 40, 2, 0),
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 775,
                              padding: EdgeInsets.only(bottom: 10),
                              width: double.infinity,
                              child: GestureDetector(
                                child: Hero(
                                  tag: heroTag,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      parentBolt['imageUrl'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  verticalController.animateToPage(
                                    1,
                                    duration: Duration(
                                      milliseconds: 300,
                                    ),
                                    curve: Curves.easeOut,
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      child: Text(
                                        parentBolt['username'],
                                        style:
                                            Theme.of(context).textTheme.body2,
                                      ),
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
                                              parentBolt['user_id'],
                                              parentBolt['username'],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Hotness(5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment(0, 0.95),
                        child: Camera(
                          user['id'],
                          _id,
                          user['username'],
                          getData,
                          make: 'spark',
                        ),
                      ),
                    ],
                  ),
                  PageView(
                    controller: horizontalController,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 40, 2, 0),
                            color: Theme.of(context).backgroundColor,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 775,
                                  padding: EdgeInsets.only(bottom: 10),
                                  width: double.infinity,
                                  child: GestureDetector(
                                    child: Hero(
                                      tag: heroTag,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Container(
                                          child: Text(
                                            username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .backgroundColor,
                                                  appBar: AppBar(),
                                                  body: ProfilePage
                                                      .notFromMainView(
                                                    user_id,
                                                    username,
                                                  ),
                                                ),
                                              ));
                                        },
                                      ),
                                      Hotness(5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, 0.95),
                            child: Camera(
                              user['id'],
                              _id,
                              user['username'],
                              getData,
                              make: 'spark',
                            ),
                          ),
                        ],
                      ),
                      ...List.generate(
                        sparks.length,
                        (index) => Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(2, 40, 2, 0),
                              color: Theme.of(context).backgroundColor,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 775,
                                    padding: EdgeInsets.only(bottom: 10),
                                    width: double.infinity,
                                    child: GestureDetector(
                                      child: Hero(
                                        tag: heroTag,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            sparks[index]['imageUrl'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        horizontalController.animateToPage(
                                          0,
                                          duration: Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeOut,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: Theme.of(context).accentColor,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                            child: Text(
                                              sparks[index]['username'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body2,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .backgroundColor,
                                                  appBar: AppBar(),
                                                  body: ProfilePage
                                                      .notFromMainView(
                                                    sparks[index]['user_id'],
                                                    sparks[index]['username'],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Hotness(5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment(0, 0.95),
                              child: Camera(
                                user['id'],
                                _id,
                                user['username'],
                                getData,
                                make: 'spark',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
  }
}
