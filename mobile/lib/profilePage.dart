import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  String id = '';
  List bolts = [];

  ProfilePage(this.id);

  @override
  _ProfilePageState createState() => _ProfilePageState(id);
}

class _ProfilePageState extends State<ProfilePage> {
  String id;
  List bolts = [];

  _ProfilePageState(this.id);

  @override
  void initState() {
    super.initState();
    getBolts();
  }

  void getBolts() async {
    String url = 'http://localhost:6000/users/$id/bolts';
    var res = await http.get(url);
    List data = json.decode(res.body);
    setState(() {
      bolts = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: List.generate(bolts.length, (index) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Image.network(bolts[index]['imageUrl']),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        bolts[index]['description'],
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
