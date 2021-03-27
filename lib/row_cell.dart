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
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField()),
        ),
        Expanded(
            child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TextField()))
      ],
    );
  }
}
