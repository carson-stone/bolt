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

  Widget hotnessWidget() => Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Image.asset(
          'assets/transparent-bolt.png',
        ),
      );

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
                      child: Image.asset(
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
                              parentBoltId: content[index]['parent_bolt_id'],
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
                              body: ProfilePage.notFromMainView(
                                  content[index]['user_id'],
                                  content[index]['username']),
                            ),
                          ));
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  Hero(
                    tag: 'row',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            content[index]['username'],
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
                  ),
                  Container(
                      // width: double.infinity,
                      // child: Text(
                      //   content[index]['description'],
                      //   style: Theme.of(context).textTheme.body1,
                      // ),
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
