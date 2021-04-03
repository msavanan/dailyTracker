import 'package:daily_tracker/database/db2Table.dart';
import 'package:daily_tracker/database/db_daily_tracker.dart';
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
    ProjectTracker projectTracker =
        Provider.of<ProjectTracker>(context, listen: false);

    DB2Table db2table = Provider.of<DB2Table>(context, listen: false);

    childWidgets = [];
    int issueTrackerLength = Provider.of<ProjectTracker>(context, listen: true)
        .issueTrackerList
        .length;
    //db2table.currentTable.issueTrackerList.length;  //

    // print('Issue Tracker Length: $issueTrackerLength');

    for (int i = 0; i < issueTrackerLength; i++) {
      print(
          'projectTracker.issueTrackerList[i].sno: ${projectTracker.issueTrackerList[i].sno}');
      childWidgets.add(RowCell(
        snoText: projectTracker.issueTrackerList[i].sno ?? '',
        issueText: projectTracker.issueTrackerList[i].issue ?? '',
        statusText: projectTracker.issueTrackerList[i].status ?? '',
      ));
      projectTracker.issueTrackerList[i].id = i;
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
                        projectTracker.addIssue();

                        print(
                            "db2table issue: ${db2table.currentTable.issueTrackerList.length}");
                        print(
                            "projectTracker length:${projectTracker.issueTrackerList.length}");
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
                        onTap: () async {
                          print('Delete row');
                          int index = projectTracker.currentIndex;
                          print(index);
                          if (index > 1) {
                            projectTracker.removeIssue();
                          }
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
