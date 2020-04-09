import 'package:flutter/material.dart';

class Hotness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Image.asset(
        'assets/transparent-bolt.png',
      ),
    );
  }
}
