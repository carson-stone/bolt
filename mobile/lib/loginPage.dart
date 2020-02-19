import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './menu.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  void login(BuildContext context) async {
    String url = 'http://localhost:6000/users/login';
    var response = await http.post(url, body: {'username': 'carson'});
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
                    login(context);
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
}
