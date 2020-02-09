import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('user 1'),
            onTap: () {},
          ),
          ListTile(
            title: Text('user 2'),
            onTap: () {},
          ),
          ListTile(
            title: Text('user 3'),
            onTap: () {
              // set up button
              Widget okButton = FlatButton(
                child: Text("OK"),
                onPressed: () {},
              );

              // set up AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("My title"),
                content: Text("This is my message."),
                actions: [
                  okButton,
                ],
              );

              // show dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
