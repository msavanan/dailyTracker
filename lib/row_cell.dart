import 'package:daily_tracker/cell.dart';
import 'package:flutter/material.dart';

class RowCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {},
              )),
        ),
        Expanded(
          flex: 4,
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                onChanged: (value) {},
              )),
        ),
        Expanded(
            child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {},
                )))
      ],
    );
  }
}
