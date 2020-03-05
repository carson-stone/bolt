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
    // return Scaffold(
    //   backgroundColor: Theme.of(context).backgroundColor,
    //   body: Hero(
    //     tag: 'bolt',
    //     child: Container(
    //       padding: EdgeInsets.all(10),
    //       alignment: Alignment.center,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           SizedBox(
    //             height: 50,
    //             child: Container(
    //               padding: EdgeInsets.all(10),
    //               alignment: Alignment.centerLeft,
    //               child: Text(
    //                 username,
    //                 style: Theme.of(context).textTheme.body2,
    //               ),
    //             ),
    //           ),
    //           GestureDetector(
    //             onLongPress: () {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => Scaffold(
    //                       backgroundColor: Theme.of(context).backgroundColor,
    //                       appBar: AppBar(
    //                         title: Text(
    //                           '$username\'s profile',
    //                           style: Theme.of(context).textTheme.title,
    //                         ),
    //                       ),
    //                       body: ProfilePage(user_id, username),
    //                     ),
    //                   ));
    //             },
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(14.0),
    //               child: GestureDetector(
    //                 child: Image.network(imageUrl),
    //                 onTap: () {
    //                   Navigator.pop(context);
    //                 },
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 100,
    //             child: Container(
    //               padding: EdgeInsets.all(10),
    //               alignment: Alignment.topLeft,
    //               child: Text(
    //                 description,
    //                 style: Theme.of(context).textTheme.body1,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
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
