import 'package:flutter/material.dart';

class Hotness extends StatelessWidget {
  int hotnessAmount;
  Hotness(this.hotnessAmount);

  @override
  Widget build(BuildContext context) {
    if (hotnessAmount == 0) {
      return Container(
        height: 50,
        child: Text(
          '😢',
          style: Theme.of(context).textTheme.title,
        ),
      );
    }

    return Row(
      children: <Widget>[
        ...List.generate(
          hotnessAmount,
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
