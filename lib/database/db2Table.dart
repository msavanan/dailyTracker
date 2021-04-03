import 'package:daily_tracker/project/project_tracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'db_daily_tracker.dart';

class DB2Table extends ChangeNotifier {
  ProjectTracker currentTable;
  DB2Table({this.currentTable});

  checkCurrentDate(BuildContext context, String date) async {
    bool cond =
        await DailyTrackerDatabase.instance.searchQuery("currentProject", date);

    if (cond) {
      await Provider.of<ProjectTracker>(context, listen: false)
          .updateTable(context, date);
    } else {
      Provider.of<ProjectTracker>(context, listen: false).setTable(context);
    }
  }

  updateTable(BuildContext context, date) async {
    print('Call from db2Table - updateTable function - line number 28');
    var tb = await DailyTrackerDatabase.instance
        .selectByDate('currentProject', date);
    var tb1 =
        await DailyTrackerDatabase.instance.selectByDate('projection', date);
    var tb2 = await DailyTrackerDatabase.instance.selectByDate('issue', date);
    print('db2table line 34');
    print('$tb');
    print('$tb1');
    print('$tb2');

    ProjectTracker projectTracker =
        Provider.of<ProjectTracker>(context, listen: false);

    projectTracker.date = tb[0]['date'];
    projectTracker.cProjectTitle = tb[0]['projectTitle'];

    projectTracker.cProjectUpdate = tb[0]['projectUpdate'];

    projectTracker.nProjectTitle = tb1[0]['projectTitle'];
    projectTracker.nProjectUpdate = tb1[0]['projectUpdate'];

    print('Call from DB2Table line number 50');
    print(projectTracker.issueTrackerList.length);

    for (int i = 0; i < tb2.length; i++) {
      projectTracker.currentIndex = i;
      projectTracker.issueTrackerList.add(IssueTracker());

      projectTracker.issueTrackerList[i].sno = tb2[i]['slno'].toString();
      projectTracker.issueTrackerList[i].issue = tb2[i]['issue'];
      projectTracker.issueTrackerList[i].status = tb2[i]['status'];
    }

    notifyListeners();
  }
}
