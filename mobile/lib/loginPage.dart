import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './menu.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  void login(BuildContext context, String username) async {
    String url = 'http://localhost:6000/users/login';
    var response = await http.post(url, body: {'username': username});
    if (jsonDecode(response.body) == 'user authenticated') {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Menu(),
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'username',
                style: Theme.of(context).textTheme.body2,
              ),
              TextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    login(context, usernameController.text);
                  }
                },
                child: Text('log in'),
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
