import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './profilePage.dart';

class BoltDetail extends StatefulWidget {
  String _id, username, imageUrl, user_id, description, heroTag;

  BoltDetail(this._id, this.username, this.imageUrl, this.user_id,
      this.description, this.heroTag);

  @override
  _BoltDetailState createState() =>
      _BoltDetailState(_id, username, imageUrl, user_id, description, heroTag);
}

class _BoltDetailState extends State<BoltDetail> {
  String _id, username, imageUrl, user_id, description, heroTag;
  List sparks = [];

  _BoltDetailState(this._id, this.username, this.imageUrl, this.user_id,
      this.description, this.heroTag);

  @override
  void initState() {
    super.initState();
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

    setState(() {
      sparks = boltsSparks;
    });
  }

  Widget hotnessWidget() => Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Image.asset(
          'assets/transparent-bolt.png',
        ),
      );

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(
      initialPage: 0,
    );

    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
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
                      child: Image.network(
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
                                body: ProfilePage(user_id, username),
                              ),
                            ));
                      },
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
              ),
            ],
          ),
        ),
        ...List.generate(
          sparks.length,
          (index) => Container(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
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
                        child: Image.network(
                          sparks[index]['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      controller.animateToPage(
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
                                  body: ProfilePage(
                                    sparks[index]['user_id'],
                                    sparks[index]['username'],
                                  ),
                                ),
                              ));
                        },
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
