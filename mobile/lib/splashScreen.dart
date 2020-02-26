import 'package:flutter/material.dart';

import './loginPage.dart';
import './registerPage.dart';

class SplashScreen extends StatelessWidget {
  Function setLoggedIn;

  SplashScreen(this.setLoggedIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/transparent-bolt.png',
              height: 250,
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              'bolt',
              style: Theme.of(context).textTheme.headline,
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(setLoggedIn)));
                },
              ),
            ),
            SizedBox(
              height: 50,
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
                    'Register',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
