import 'package:daily_tracker/cell.dart';
import 'package:flutter/material.dart';

class EditableCell extends StatelessWidget {
  final bool editable;
  final Function onChanged;
  EditableCell({this.editable, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return editable
        ? Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: TextField(
              onChanged: onChanged,
            ))
        : Cell(
            txt: '',
          );
  }
}
