import 'package:flutter/material.dart';

import './menu.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                'usernamwe',
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
                  print(_formKey.currentState.validate());
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
