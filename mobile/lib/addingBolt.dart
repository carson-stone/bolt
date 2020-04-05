import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddingBolt extends StatefulWidget {
  var bolt;
  String userID, username;
  Function getData;

  AddingBolt(this.bolt, id, this.username, this.getData) : this.userID = id;

  @override
  _AddingBoltState createState() =>
      _AddingBoltState(bolt, userID, username, getData);
}

class _AddingBoltState extends State<AddingBolt> {
  var bolt;
  String userID, username;
  Function getData;

  _AddingBoltState(this.bolt, this.userID, this.username, this.getData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 775,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: double.infinity,
            child: Hero(
              tag: 'bolt',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  bolt,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    'add this bolt?',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                FlatButton(
                    child: Text(
                      'yes',
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .copyWith(color: Theme.of(context).accentColor),
                    ),
                    onPressed: () {
                      String url = 'http://localhost:6000/bolts/add';
                      http.post(url, body: {
                        'imageUrl':
                            'https://i.pinimg.com/originals/23/ea/f4/23eaf478ef5045c041b415bab66220c9.jpg',
                        'username': username,
                        'user_id': userID,
                        'description': 'a bolt'
                      });
                      getData();
                      Navigator.pop(context);
                    }),
                FlatButton(
                  child: Text(
                    'no',
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
