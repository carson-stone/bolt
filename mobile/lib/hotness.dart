import 'package:flutter/material.dart';

class Hotness extends StatelessWidget {
  int sparkAmount;
  Hotness(this.sparkAmount);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ...List.generate(
          sparkAmount,
          (index) => Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Image.asset(
              'assets/transparent-bolt.png',
            ),
          ),
        ),
      ],
    );
  }
}
