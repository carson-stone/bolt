import 'package:flutter/material.dart';

import './menu.dart';

class AboutPage extends StatelessWidget {
  Function setLoggedIn;

  AboutPage(this.setLoggedIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 75,
                ),
                Container(
                  height: 50,
                  child: Image.asset('assets/transparent-bolt.png'),
                ),
                SizedBox(
                  height: 300,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                          color: Theme.of(context).accentColor, width: 4),
                    ),
                    child: RaisedButton(
                      color: Theme.of(context).backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Log Out',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () {
                        setLoggedIn(false, "", "");
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment(-0.8, -0.8),
              child: GestureDetector(
                child: Icon(Icons.arrow_back_ios),
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
