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
    int index =
        Provider.of<ProjectTracker>(context, listen: false).currentIndex;

    TextEditingController snoController = TextEditingController();
    TextEditingController issueController = TextEditingController();
    TextEditingController statusController = TextEditingController();

    snoController.text = widget.snoText;
    issueController.text = widget.issueText;
    statusController.text = widget.statusText;

    if (index <=
        Provider.of<ProjectTracker>(context, listen: false)
            .issueTrackerList
            .length) {
      Provider.of<ProjectTracker>(context, listen: false)
          .issueTrackerList
          .add(IssueTracker());
    } else {
      Provider.of<ProjectTracker>(context, listen: false)
          .issueTrackerList[index] = IssueTracker();
    }

    return Row(
      children: [
        Expanded(
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  Provider.of<ProjectTracker>(context, listen: false)
                      .issueTrackerList[index]
                      .sno = int.parse(value);
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
                  /*int index =
                      Provider.of<ProjectTracker>(context, listen: false)
                          .currentIndex;*/
                  Provider.of<ProjectTracker>(context, listen: false)
                      .issueTrackerList[index]
                      .issue = value;
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
                    /*int index =
                        Provider.of<ProjectTracker>(context, listen: false)
                            .currentIndex;*/
                    Provider.of<ProjectTracker>(context, listen: false)
                        .issueTrackerList[index]
                        .status = value;
                  },
                  controller: statusController,
                )))
      ],
    );
  }
}
