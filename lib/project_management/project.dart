import 'package:flutter/material.dart';

class Project {
  String title;
  int number;

  Project({@required int number, @required String title}) {
    this.number = number;
    this.title = title;
  }
}
