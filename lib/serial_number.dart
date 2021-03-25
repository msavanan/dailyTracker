import 'package:daily_tracker/cell.dart';
import 'package:flutter/material.dart';

class SerialNumber extends StatelessWidget {
  final number;
  SerialNumber({this.number});
  @override
  Widget build(BuildContext context) {
    return Center(child: Cell(txt: '$number'));
  }
}
