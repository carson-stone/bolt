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
      padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 775,
            padding: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 1,
                ),
              ),
            ),
            child: GestureDetector(
              child: Hero(
                tag: 'bolt',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  username,
                  style: Theme.of(context).textTheme.body2,
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
        ],
      ),
    );
  }
}
