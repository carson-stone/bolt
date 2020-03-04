import 'package:flutter/material.dart';

import './profilePage.dart';

class BoltDetail extends StatelessWidget {
  String username, imageUrl, user_id, description;

  BoltDetail(this.username, this.imageUrl, this.user_id, this.description);

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
      padding: EdgeInsets.only(top: 35),
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              child: Hero(
                tag: 'bolt',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(imageUrl),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
