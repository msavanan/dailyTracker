import 'package:daily_tracker/database/db_daily_tracker.dart';
import 'package:daily_tracker/project/project_tracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Table2db {
  updateDB(BuildContext context) async {
    ProjectTracker projectTracker =
        Provider.of<ProjectTracker>(context, listen: false);
    print("call from Table2DB");
    print("${projectTracker.date}");
    for (int i = 0; i < projectTracker.issueTrackerLength; i++) {
      print("table2db line number 13");
      print('$i');
      await DailyTrackerDatabase.instance.insert('issue', {
        "date": projectTracker.date,
        "slno": projectTracker.issueTrackerList[i].sno,
        "issue": projectTracker.issueTrackerList[i].issue,
        "status": projectTracker.issueTrackerList[i].status,
      });
    }

    await DailyTrackerDatabase.instance.insert('currentProject', {
      "date": projectTracker.date,
      "projectTitle": projectTracker.cProjectTitle,
      "projectUpdate": projectTracker.cProjectUpdate,
    });

    await DailyTrackerDatabase.instance.insert('projection', {
      "date": projectTracker.date,
      "projectTitle": projectTracker.nProjectTitle,
      "projectUpdate": projectTracker.nProjectUpdate,
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
