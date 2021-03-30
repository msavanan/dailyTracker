import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String txt;

  Cell({this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(child: Text(txt)),
    );
  }
}
