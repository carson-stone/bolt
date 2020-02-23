import 'package:flutter/material.dart';

class BoltDetail extends StatelessWidget {
  String username, imageUrl;

  BoltDetail(this.username, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Text(
                  username,
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: GestureDetector(
                child: Image.network(imageUrl),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
