import 'package:flutter/material.dart';

import './menu.dart';

class AboutPage extends StatelessWidget {
  Function setLoggedIn;
  final _formKey = GlobalKey<FormState>();
  final bioController = TextEditingController();

  AboutPage(this.setLoggedIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                SizedBox(
                  height: 75,
                ),
                Container(
                  height: 50,
                  child: Image.asset('assets/transparent-bolt.png'),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'bio:',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(70, 5, 70, 5),
                  child: TextFormField(
                    maxLines: 2,
                    style: Theme.of(context).textTheme.body1,
                    controller: bioController,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
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
                          if (_formKey.currentState.validate()) {
                            setLoggedIn(false, "", "");
                            Navigator.pop(context);
                          }
                        },
                      ),
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
