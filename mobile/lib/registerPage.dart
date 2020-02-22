import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();

  void register(BuildContext context, String username) async {
    String url = 'http://localhost:6000/users/register';
    var response = await http.post(url, body: {'username': username});
    if (jsonDecode(response.body) == 'user added') {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                    'Register',
                    style: TextStyle(fontSize: 22),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      register(context, usernameController.text);
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
