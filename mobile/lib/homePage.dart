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
              Container(
                height: 400,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.0),
                  child: GestureDetector(
                    child: Hero(
                      tag: 'bolt',
                      child: Image.network(
                        content[index]['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BoltDetail(
                              content[index]['_id'],
                              content[index]['username'],
                              content[index]['imageUrl'],
                              content[index]['user_id'],
                              content[index]['description'],
                              'bolt',
                            ),
                          ));
                    },
                    onLongPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              appBar: AppBar(),
                              body: ProfilePage(content[index]['user_id'],
                                  content[index]['username']),
                            ),
                          ));
                    },
                  ),
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
