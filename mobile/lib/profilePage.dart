import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  String id = '';

  ProfilePage(this.id);

  @override
  _ProfilePageState createState() => _ProfilePageState(id);
}

class _ProfilePageState extends State<ProfilePage> {
  String id;

  _ProfilePageState(this.id);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          ListTile(title: Text(id), onTap: () {}),
        ],
      ),
    );
  }
}
