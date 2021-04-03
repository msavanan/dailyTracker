import 'package:daily_tracker/xcel/cell.dart';
import 'package:flutter/material.dart';

class EditableCell extends StatefulWidget {
  final Function onChanged;
  final String initialText;
  EditableCell({this.onChanged, this.initialText});

  @override
  _EditableCellState createState() => _EditableCellState();
}

class _EditableCellState extends State<EditableCell> {
  @override
  Widget build(BuildContext context) {
    TextEditingController editCellController = TextEditingController();
    editCellController.text = widget.initialText;
    //TextEditingValue(text: widget.initialText);

    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: TextField(
          controller: editCellController,
          onChanged: widget.onChanged,
        ));
  }
}
