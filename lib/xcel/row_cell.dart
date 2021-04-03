import 'package:daily_tracker/project/project_tracker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RowCell extends StatefulWidget {
  final snoText;
  final issueText;
  final statusText;
  RowCell({this.snoText, this.issueText, this.statusText});

  @override
  _RowCellState createState() => _RowCellState();
}

class _RowCellState extends State<RowCell> {
  @override
  Widget build(BuildContext context) {
    ProjectTracker projectTracker = Provider.of<ProjectTracker>(context);
    int index = projectTracker.activeRow;

    TextEditingController snoController = TextEditingController();
    TextEditingController issueController = TextEditingController();
    TextEditingController statusController = TextEditingController();

    snoController.text = widget.snoText;
    issueController.text = widget.issueText;
    statusController.text = widget.statusText;

    return Row(
      children: [
        Expanded(
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  projectTracker.issueTrackerList[index].sno = value;
                },
                controller: snoController,
              )),
        ),
        Expanded(
          flex: 4,
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                onChanged: (value) {
                  projectTracker.issueTrackerList[index].issue = value;
                },
                controller: issueController,
              )),
        ),
        Expanded(
            child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    projectTracker.issueTrackerList[index].status = value;
                  },
                  controller: statusController,
                )))
      ],
    );
  }
}
