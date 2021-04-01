import 'package:daily_tracker/project/project_tracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'db_daily_tracker.dart';

class DB2Table extends ChangeNotifier {
  ProjectTracker currentTable;
  DB2Table({this.currentTable});

  checkCurrentDate(BuildContext context, String date) async {
    bool cond =
        await DailyTrackerDatabase.instance.searchQuery("currentProject", date);

    if (cond) {
      await updateTable(context, date);
    } else {
      setTable(context);
    }
  }

  setTable(BuildContext context) {
    print('Call from db2Table - setTable function - line number 24');

    currentTable.date = '${DateFormat.yMMMd().format(DateTime.now())}';
    currentTable.cProjectTitle = '';
    currentTable.cProjectUpdate = '';

    currentTable.nProjectTitle = '';
    currentTable.nProjectUpdate = '';

    currentTable.issueTrackerList.add(IssueTracker());

    currentTable.currentIndex = 0;
    currentTable.issueTrackerList[0].sno = '';
    currentTable.issueTrackerList[0].issue = '';
    currentTable.issueTrackerList[0].status = '';
    notifyListeners();
  }

  updateTable(BuildContext context, date) async {
    print('Call from db2Table - updateTable function - line number 40');
    var tb = await DailyTrackerDatabase.instance
        .selectByDate('currentProject', date);
    var tb1 =
        await DailyTrackerDatabase.instance.selectByDate('projection', date);
    var tb2 = await DailyTrackerDatabase.instance.selectByDate('issue', date);
    print('db2table line 64');
    print('$tb');
    print('$tb1');
    print('$tb2');

    currentTable.date = tb[0]['date'];
    currentTable.cProjectTitle = tb[0]['projectTitle'];

    currentTable.cProjectUpdate = tb[0]['projectUpdate'];

    currentTable.nProjectTitle = tb1[0]['projectTitle'];
    currentTable.nProjectUpdate = tb1[0]['projectUpdate'];

    print('Call from DB2Table line number 98');
    print(currentTable.issueTrackerList.length);

    for (int i = 0; i < tb2.length; i++) {
      /*print('From db2Table line number 66');
      print(i); */
      currentTable.currentIndex = i;
      currentTable.issueTrackerList.add(IssueTracker());

      currentTable.issueTrackerList[i].sno = tb2[i]['slno'].toString();
      currentTable.issueTrackerList[i].issue = tb2[i]['issue'];
      currentTable.issueTrackerList[i].status = tb2[i]['status'];
    }
    notifyListeners();
  }
}
