import 'package:flutter/material.dart';

import './profilePage.dart';
import './boltDetail.dart';

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

    return PageView(
      controller: PageController(
        initialPage: 0,
      ),
      scrollDirection: Axis.vertical,
      children: List.generate(content.length, (index) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: GestureDetector(
                  child: Image.network(content[index]['imageUrl']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BoltDetail(
                              content[index]['username'],
                              content[index]['imageUrl'],
                              content[index]['user_id'],
                              content[index]['description']),
                        ));
                  },
                  onLongPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            backgroundColor: Theme.of(context).backgroundColor,
                            appBar: AppBar(
                              title: Text(
                                content[index]['username'] + "'s profile",
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                            body: ProfilePage(content[index]['user_id'],
                                content[index]['username']),
                          ),
                        ));
                  },
                ),
              ),
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
