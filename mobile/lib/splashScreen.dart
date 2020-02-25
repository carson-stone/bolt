import 'package:flutter/material.dart';

import './loginPage.dart';
import './registerPage.dart';

class SplashScreen extends StatelessWidget {
  Function setLoggedIn;

  SplashScreen(this.setLoggedIn);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[50],
        accentColor: Colors.purple,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'bolt',
                style: TextStyle(fontSize: 42),
              ),
              SizedBox(
                width: 200,
                height: 100,
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
                    style: TextStyle(fontSize: 22),
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
                width: 200,
                height: 50,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.purple, width: 4),
                  ),
                  child: RaisedButton(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 22),
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
      ),
    );
  }
}
