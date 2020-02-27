import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  Function setLoggedIn;

  LoginPage(this.setLoggedIn);
  LoginPage.fromAnotherPage();

  @override
  _LoginPageState createState() => _LoginPageState(setLoggedIn);
}

class _LoginPageState extends State<LoginPage> {
  Function setLoggedIn;

  _LoginPageState(this.setLoggedIn);

  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  void login(BuildContext context, String username) async {
    String url = 'http://localhost:6000/users/login';
    var response = await http.post(url, body: {'username': username});
    if (json.decode(response.body).startsWith('user authenticated')) {
      setLoggedIn(true, username, json.decode(response.body).split(':')[1]);
      Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Form(
          key: _formKey,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment(-0.8, -0.8),
                child: GestureDetector(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Image.asset('assets/transparent-bolt.png'),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    'username',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(70, 5, 70, 5),
                    child: TextFormField(
                      controller: usernameController,
                      style: Theme.of(context).textTheme.body1,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Text(
                    'password',
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(70, 5, 70, 5),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.body1,
                      controller: usernameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 150,
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
                        if (_formKey.currentState.validate()) {
                          login(context, usernameController.text);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }
}
