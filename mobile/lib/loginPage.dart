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
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'username',
                style: Theme.of(context).textTheme.body2,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(70, 15, 70, 15),
                child: TextFormField(
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
                height: 50,
              ),
              Text(
                'password',
                style: Theme.of(context).textTheme.body2,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(70, 15, 70, 15),
                child: TextFormField(
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
                height: 200,
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
