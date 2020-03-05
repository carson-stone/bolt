import 'package:flutter/material.dart';

class AddingBolt extends StatefulWidget {
  var bolt;

  AddingBolt(this.bolt);

  @override
  _AddingBoltState createState() => _AddingBoltState(bolt);
}

class _AddingBoltState extends State<AddingBolt> {
  var bolt;

  _AddingBoltState(this.bolt);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 775,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: double.infinity,
            child: GestureDetector(
              child: Hero(
                tag: 'bolt',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    bolt,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
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
                  onPressed: () => Navigator.pop(context),
                ),
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
