import 'package:flutter/material.dart';

import './profilePage.dart';

class BoltDetail extends StatelessWidget {
  String username, imageUrl, user_id, description;

  BoltDetail(this.username, this.imageUrl, this.user_id, this.description);

  Widget hotnessWidget() => Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Image.asset(
          'assets/transparent-bolt.png',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
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
                tag: 'bolt',
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
            // margin: EdgeInsets.only(top: 10),
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
                            backgroundColor: Theme.of(context).backgroundColor,
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
    );
  }
}
