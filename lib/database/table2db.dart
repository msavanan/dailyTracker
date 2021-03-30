import 'package:daily_tracker/database/db_daily_tracker.dart';
import 'package:daily_tracker/project/project_tracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Table2db {
  ProjectTracker currentTable = ProjectTracker();
  updateDB(BuildContext context) async {
    currentTable.date =
        Provider.of<ProjectTracker>(context, listen: false).date ??
            '${DateFormat.yMMMd().format(DateTime.now())}';

    currentTable.cProjectTitle =
        Provider.of<ProjectTracker>(context, listen: false).cProjectTitle;
    currentTable.cProjectUpdate =
        Provider.of<ProjectTracker>(context, listen: false).cProjectUpdate;
    currentTable.nProjectTitle =
        Provider.of<ProjectTracker>(context, listen: false).nProjectTitle;
    currentTable.nProjectUpdate =
        Provider.of<ProjectTracker>(context, listen: false).nProjectUpdate;
    currentTable.currentIndex =
        Provider.of<ProjectTracker>(context, listen: false).currentIndex;
    /*print(currentTable.date);
    print(currentTable.cProjectTitle);
    print(currentTable.cProjectUpdate);
    print(currentTable.currentIndex); */
    for (int i = 0; i <= currentTable.currentIndex; i++) {
      currentTable.issueTrackerList.add(IssueTracker());
      currentTable.issueTrackerList[i].sno =
          Provider.of<ProjectTracker>(context, listen: false)
              .issueTrackerList[i]
              .sno;
      currentTable.issueTrackerList[i].issue =
          Provider.of<ProjectTracker>(context, listen: false)
              .issueTrackerList[i]
              .issue;
      currentTable.issueTrackerList[i].status =
          Provider.of<ProjectTracker>(context, listen: false)
              .issueTrackerList[i]
              .status;
      /*print(currentTable.issueTrackerList[i].sno);
      print(currentTable.issueTrackerList[i].issue);
      print(currentTable.issueTrackerList[i].status); */
      await DailyTrackerDatabase.instance.insert('issue', {
        "date": currentTable.date,
        "slno": currentTable.issueTrackerList[i].sno,
        "issue": currentTable.issueTrackerList[i].issue,
        "status": currentTable.issueTrackerList[i].status,
      });
    }
    /*print(currentTable.nProjectTitle);
    print(currentTable.nProjectUpdate); */

    await DailyTrackerDatabase.instance.insert('currentProject', {
      "date": currentTable.date,
      "projectTitle": currentTable.cProjectTitle,
      "projectUpdate": currentTable.cProjectUpdate,
    });

    await DailyTrackerDatabase.instance.insert('projection', {
      "date": currentTable.date,
      "projectTitle": currentTable.nProjectTitle,
      "projectUpdate": currentTable.nProjectUpdate,
    });

    checkDB();
  }
}

checkDB() async {
  var tb = await DailyTrackerDatabase.instance.select('currentProject');
  var tb1 = await DailyTrackerDatabase.instance.select('projection');
  var tb2 = await DailyTrackerDatabase.instance.select('issue');
  print('table2db line 64');
  print('$tb');
  print('$tb1');
  print('$tb2');
}
