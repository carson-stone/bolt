import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './menu.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  void register(BuildContext context) async {
    String url = 'http://localhost:6000/users/register';
    var response = await http.post(url, body: {'username': 'carson'});
    if (jsonDecode(response.body) == 'user added') {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Menu(),
      appBar: AppBar(
        title: Text('register'),
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
                    register(context);
                  }
                },
                child: Text('register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
