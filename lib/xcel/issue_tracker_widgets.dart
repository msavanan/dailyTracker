import 'package:daily_tracker/database/db2Table.dart';
import 'package:daily_tracker/project/project_tracker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cell.dart';
import 'row_cell.dart';

class IssueTrackerWidget extends StatefulWidget {
  @override
  _IssueTrackerWidgetState createState() => _IssueTrackerWidgetState();
}

class _IssueTrackerWidgetState extends State<IssueTrackerWidget> {
  List<Widget> childWidgets = [];

  @override
  Widget build(BuildContext context) {
    int length =
        Provider.of<DB2Table>(context, listen: true).currentTable.currentIndex;

    if (childWidgets.length == 0 && length == 0) {
      childWidgets.add(RowCell(
        snoText: '',
        issueText: '',
        statusText: '',
      ));
    } else if (length > 0) {
      print("call from main line number 116");
      print('${childWidgets.length}');
      childWidgets = [];
      for (int i = 0; i <= length; i++) {
        childWidgets.add(RowCell(
          snoText: Provider.of<DB2Table>(context, listen: false)
              .currentTable
              .issueTrackerList[i]
              .sno,
          issueText: Provider.of<DB2Table>(context, listen: false)
              .currentTable
              .issueTrackerList[i]
              .issue,
          statusText: Provider.of<DB2Table>(context, listen: false)
              .currentTable
              .issueTrackerList[i]
              .status,
        ));
      }
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Cell(
                txt: 'SL No',
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Container(
                          height: 50,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Icon(Icons.add)),
                      onTap: () {
                        print('Add row');

                        int currentIndex =
                            Provider.of<ProjectTracker>(context, listen: false)
                                .currentIndex;
                        Provider.of<ProjectTracker>(context, listen: false)
                            .currentIndex = currentIndex + 1;
                        setState(() {
                          childWidgets.add(RowCell(
                            snoText: '',
                            issueText: '',
                            statusText: '',
                          ));
                        });
                      },
                    ),
                    Expanded(
                      child: Cell(
                        txt: 'Issue',
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: GestureDetector(
                        child: Icon(Icons.remove),
                        onTap: () {
                          print('Delete row');
                          int currentIndex = Provider.of<ProjectTracker>(
                                  context,
                                  listen: false)
                              .currentIndex;
                          if (currentIndex != 0) {
                            Provider.of<ProjectTracker>(context, listen: false)
                                .currentIndex = currentIndex - 1;
                          }

                          setState(() {
                            int index = childWidgets.length - 1;
                            currentIndex = Provider.of<ProjectTracker>(context,
                                    listen: false)
                                .currentIndex;
                            Provider.of<ProjectTracker>(context, listen: false)
                                .currentIndex = currentIndex - 1;
                            childWidgets.removeAt(index);
                            print('From main at line 271');
                            print(childWidgets.length);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Cell(
                txt: 'Status',
              ),
            )
          ],
        ),
        Column(
          children: childWidgets,
        ),
      ],
    );
  }
}
