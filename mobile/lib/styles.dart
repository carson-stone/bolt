import 'package:flutter/material.dart';

class BodyTextStyle extends TextStyle {
  @override
  double get fontSize => 18.0;
}

class EmphasizedBodyTextStyle extends TextStyle {
  @override
  double get fontSize => 24.0;

  @override
  FontWeight get fontWeight => FontWeight.bold;
}
