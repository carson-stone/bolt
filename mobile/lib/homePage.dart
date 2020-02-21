import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  List content = [];

  HomePage(this.content);
  HomePage.fromLogin();

  @override
  _HomePageState createState() => _HomePageState(content);
}

class _HomePageState extends State<HomePage> {
  List content = [];

  _HomePageState(this.content);

  @override
  Widget build(BuildContext context) {
    content = widget.content;
    return ListView(
      children: List.generate(content.length, (index) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Image.network(content[index]['imageUrl']),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      content[index]['username'],
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      content[index]['description'],
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
