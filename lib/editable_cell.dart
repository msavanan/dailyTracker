import 'package:daily_tracker/cell.dart';
import 'package:flutter/material.dart';

class EditableCell extends StatelessWidget {
  final bool editable;
  EditableCell({this.editable});
  @override
  Widget build(BuildContext context) {
    return editable
        ? Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: TextField())
        : Cell(
            txt: '',
          );
  }
}
