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
      updateTable();
    } else {
      setTable();
    }
  }

  setTable() {
    currentTable.date = '${DateFormat.yMMMd().format(DateTime.now())}';
    currentTable.cProjectTitle = '';
    currentTable.cProjectUpdate = '';

    currentTable.nProjectTitle = '';
    currentTable.nProjectUpdate = '';

    currentTable.issueTrackerList[0].sno = 1;
    currentTable.issueTrackerList[0].issue = '';
    currentTable.issueTrackerList[0].status = '';
  }

  updateTable() async {
    var tb = await DailyTrackerDatabase.instance.select('currentProject');
    var tb1 = await DailyTrackerDatabase.instance.select('projection');
    var tb2 = await DailyTrackerDatabase.instance.select('issue');
    print('db2table line 64');
    /*print('$tb');
    print('$tb1');
    print('$tb2');*/
    currentTable.date = tb[0]['date'];
    currentTable.cProjectTitle = tb[0]['projectTitle'];
    currentTable.cProjectUpdate = tb[0]['projectUpdate'];

    currentTable.nProjectTitle = tb1[0]['projectTitle'];
    currentTable.nProjectUpdate = tb1[0]['projectUpdate'];

    if (currentTable.issueTrackerList.length > 0) {
      for (int i = 0; i < tb2.length; i++) {
        print(currentTable.issueTrackerList.length);
        currentTable.issueTrackerList[i].sno = tb2[i]['slno'];
        currentTable.issueTrackerList[i].issue = tb2[i]['issue'];
        currentTable.issueTrackerList[i].status = tb2[i]['status'];
      }
    }
  }
}
