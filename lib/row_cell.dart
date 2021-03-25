import 'package:daily_tracker/cell.dart';
import 'package:flutter/material.dart';

class RowCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Cell(
            txt: '',
          ),
        ),
        Expanded(
          flex: 4,
          child: TextField(),
        ),
        Expanded(
          child: TextField(),
        )
      ],
    );
  }
}
